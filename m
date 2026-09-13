Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782FE3264D2
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319786; cv=none; b=LY6fWQg9l699V20MNpIsAF15RDu7TMWzCLCKkWiEK0w/F7TTk7vKcJhWlz/jDzpA4M6FHczNKzDk46AbnJ1PDtw3RjYg4OpFjStZYSLcZdoiPv3KIWpxzXQd2FRU2roR2zFNLr8ytykvU+9wPF6vBa94fnKcWe9qwZvO3t3j4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319786; c=relaxed/simple;
	bh=GsiEyTTtrFkVeKzI3GAUfho2KDexrIR9NK7lLBsu+4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utW78iYpgM+7o/MuD4x7BrevxuAFrJFuBBmOpu5ieQ/mFzJyeiSa642KZ2yNi1/Tw7z1LpU45jSyJzae1oKRjfotbz0YgN1YEnG/hb55A50BZzPmSxJ2GP6oRJ5kG4rBEhAlVoZzpQVrfzDqZvdmODG+rhM/h0ajd+DO8G9R5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+sgWtQh; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+sgWtQh"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d4eb63f0aso4202387b3.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789319779; x=1789924579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gqTg4s+n4SjPh/18VLqNSc11mHpOLMKDJqGb8N0vbEM=;
        b=E+sgWtQhBT94/APMPFgCqEi569++/4Se6crJvHA7vLwu/VewoIrsklYyaqD543IejV
         BqB3iWUQ0GdLD/QQX3YP1Xhr6Sx9YUOgwAhnnqD4PnOlm0LMwasE052P7AyVPoFO6+d4
         CwwPMxwL8WkxIvmzN5UB++fC+1P189uwR9RjJMqiC7MGOD+IeMV7s+S2d+gc0eterJE7
         KH6oIiJdMGO6xLMEsIsnHnQDPl/GiOJYLAV2XlDxb7yQcl8zy9YP0MdUjCDGDbeX1e9x
         YEJKOF7LDTCVeAz10PYXiSiQCPQKA+DFEe5BQCrlZiDlwIjyRHNf1sHmt2D6q4ZO8oAY
         u/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789319779; x=1789924579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gqTg4s+n4SjPh/18VLqNSc11mHpOLMKDJqGb8N0vbEM=;
        b=Ny9eozslNOtZ64VM/wDtfD9n+DfB314Udq/ohxqF/LzxxhvnGS/LsOM+nONVrmgu4l
         97Dfg04CMCjlMO2aFTIA0pR3VrN+Qt5n0KXzKVTSmvBdHA96xBbc6h5tyQHOT5uCajp/
         zHijdKxBCh/VqmD5NoTKuJgfQn4pVdqzDGnNiJDh5KG6I3kbHD0s+bpIk2sRUkjtFwe5
         flrcqsl6wXYCRTsHqyXJTAnC3ONSvffK+K6a82mnNj6hpds5kaOz/zjvLRvVKfB/mkmm
         LPu5MZuNywBkAIJnqqtbFHgYW0gYc5ZhiJ8ISseVhmDfCrDvJvmWjYTNmyUx8cP4tfzC
         wn2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzzZukAaDpfNyCYtJHEHuXHgK0oIq0zUxrx1YAPFoAuc/cD8ZVMtlGiR2/3hdBd3ZJ11IJv344=@vger.kernel.org
X-Gm-Message-State: AFuF++la7BKbk+0P69zdu0GallxFvT12UtOTnTQxveYuNi04m/q9Txa+
	ZSz83SszANqGuon2YHMKIJ8aefiiiRKyh+Pyv6yVUjNeAUbTcJ13XQLw
X-Gm-Gg: AYBFou0N6oIxAwfSzVFm8QcjlzrCknkDujE0cm8tcWA83yhLCIrmAIsH9OSLzxWUUuD
	P0ydS+7L3Pox4lcG8ousGEsxJVCEaX+u+e/yEiEmZNFZ+mP+2ZCAZwpzPl0Xk84mMeGskpLj5NM
	MU5TGN/jFZclOEyceojsYjTQWBkg3rBk727i/HwiKu4oHbdGUXNx70o964wgiyn5TG2PH/Mx/8h
	lGId0a9dRmqrCWdxZDmHReHiMzDuxUfFcWOmz5Cu3UbZ4dTEyIelnYjks2h1NRbkewuFMoxvKfE
	cJAp908FCQK/mpQQ/1m4AJ641FKMFQ+WpFDew4+RO+kTshGsQi8utnoccZ4gD4KCpThGGbtRRKM
	Nkan9JBeWhBcdMlpaqE/w7ZOVAUQ1qP2pqse6GVG9tS9ZzyDqlzJ6n7VkLhrpb0DH7gf41A6meX
	MCNlsz3m0LmrvItsRf2aE/PD8t+YIGpUoQQOYesL71wQFeZ1KrCRMYI6RLf1evKg==
X-Received: by 2002:a05:690c:dc5:b0:81e:d001:e0ca with SMTP id 00721157ae682-88a8d2cc57dmr4418897b3.17.1789319779206;
        Sun, 13 Sep 2026 10:16:19 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8847db4476bsm29210607b3.5.2026.09.13.10.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 10:16:18 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-net v2 0/2] e1000e: fix Rx DMA error handling
Date: Sun, 13 Sep 2026 13:15:53 -0400
Message-ID: <20260913171555.89537-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some longstanding bugs in Rx DMA error handling.

These two patches eliminate some conditions which would result in
DMA_MAPPING_ERROR being sent to h/w or to dma_unmap_page() or
dma_unmap_single(). A teardown leak in the packet-splitting path is also
fixed by a necessary refactor.

v2:
* Renamed series from "e1000e: fix Rx bugs"
* Removed RXALL buffer overrun fix from the series.
  RXALL bugs will be fixed in a separate series.
* Reworded patch commit messages.

Matt Vollrath (2):
  e1000e: fix Rx skb DMA map error sentinel
  e1000e: fix ps_pages DMA map error sentinel

 drivers/net/ethernet/intel/e1000e/netdev.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)


base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
-- 
2.43.0

