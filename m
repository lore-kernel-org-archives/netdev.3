Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810EB420E9F
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648084; cv=none; b=L+KBN5c/mIhTMKOyCFoHRb0YvZ5irDUsL4cvbZ/jEOyNk8bzjrcF9r1DQnbrGg9DvtYZz7irw3JFEgVrcvDZM16/O981D7oNakjKvifZduUZPxHKwsLzUA5TWX9px/AZZ6Q0YD1XeIi5/nuD2+9lU/jnoKXUTPqHsNOKUnFVU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648084; c=relaxed/simple;
	bh=Na7MS/Up8XTKb4IX9xJjbtZxGJ7cnEgnEI7V0oawB80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb2emzgkk8PEPrzGilS0tKLztCwgSUIhxYcGy6zZ9goTHztNG5lLsyT6oMjF6ptZDLu9bCBKqBMJR5sRl6ImewNaUyzWy4h6NZp8Sx4mzIzFSa9qabwrSisHsl/RGxKhf6mKCFHOSXGuwVz5GW/MTDOU39XQlaqf+q5uyFhklOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJzKuBu9; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJzKuBu9"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-380f4166f80so159521a91.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786648083; x=1787252883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=akUZ9dYiYWC1oUDGRGEMMoCmBNHpXpllEedbay7GMFg=;
        b=SJzKuBu9wHTjWU9bGfrFJ+r9NiOTAfKB6oHWsgxB2gGcLkXlNuw/60fSe5HwgLxFKV
         Lwn4556+mOBdsiI1xDIPh3O2lmQ6ArIXj3+b2LhXe9HUec8/HhLOiCHa5iQfB6qbWsgK
         gkTPoaLqhYPQTOwAyNbKLfgsPDnaFmboTGIA+m3HkrAezqlhff+2eenRlwrdR8qBgHGB
         GaAFJfzp7ZVNjuBm0kL8g6b9xYAFVTqOXD1Xeh+RwfqPM3uMd70j83ZnmqtzwLZewAEc
         OJjCSEiDCuCvk+9fRSvg9kV2LMeAGHfIoAkBMkixW1E1NLz/Om8a7iJ4OMGP94yaAnw3
         rMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786648083; x=1787252883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=akUZ9dYiYWC1oUDGRGEMMoCmBNHpXpllEedbay7GMFg=;
        b=MjqWY6Q8QXPlBiB9ZloJ5AU30UvO4IJxTWiu4T4ih0c2Xg3io2E2HKW/WgtVVCfmS6
         0BBnZqOQb0zzoCigN64MDydJk/24Mxz6hlVYKKxrSn6BsLQgOnS3GZTQiKaw/W8IrpFC
         A6a2eInWYW7IgtW1Z4/SREAsuwAAE0AeE8WzXuWQKc7EMQCGwNjkMM6cQfBdFSiJOBWA
         t0R0UNIYwtWCSB7qqcEVsRqtKKm1BRwTtARw/MSMTPwg+mZWnOxP+3n/evUuBHfjZoEw
         09U83Hrd8ziqg0YhWmgiQD0LgsizToMUoxe+D/H0wZK7pV7TGjUgOkm+F+/r6V/81tj6
         OFKg==
X-Gm-Message-State: AOJu0Yxr4/IBzpstwZn3cv5eA/w3p5ISpCjNSqMuNFeENS+X9fiWiqge
	GyWRV/Dt+juHASKSlokh+99pdnBJpxCEsBSqTw4P08DAecmk6QBAqNLhmVNuN2pN
X-Gm-Gg: AR+sD11S326iELRrDmi962Ud+BbmI1oHF9j25Oo8S06lihQPqX6otLwzpEb6k7f70Zb
	847kv82IxUap1cun4XVgqUVUkkgomouhUghWN/HVYpHo+g6JQS9IlAN4e+6I5g/3BG/nhqNQ3x+
	KpaxVCmm/huUFK8hCaP6cWhXRRFZReD1MvYPqhOedvN3I4TYXUjGYsYCY1Py4MpZoNRtTMQvirj
	4yBbUJCi3hKQ0V3u3z6bSRcmkkxXEq50oOWSZE5MIXDiAv1AohTTZg43jl0n8eXGzxgQdJeTUpl
	gtvR7zrmqkfnC463v/IVCP6inJkQhz3ZafeBjqfOn/Bssrdr7UOkqC/1eI8I3JdCy689iuauU5z
	nWpgpjKTdIyxbISHFzQHCnitTiBq6jV2VlkO8FwswO++mkeY09GcQBjzwY1WMpvDWt6XlApcUvL
	G+RGvH3X9HqyueJF/NBtY2Yp+s5QlwKhX6yl5pa/QcQglogD6WfXIAdA==
X-Received: by 2002:a17:90b:2b8e:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-3933b8aa611mr183995a91.15.1786648082609;
        Thu, 13 Aug 2026 12:08:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933a009f35sm492119a91.15.2026.08.13.12.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:08:02 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	witu@nvidia.com,
	martin.lau@kernel.org,
	yoong.siang.song@intel.com,
	rohan.g.thomas@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net v2 1/3] xsk: align TX metadata layout across ABIs
Date: Thu, 13 Aug 2026 12:07:58 -0700
Message-ID: <20260813190800.222527-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813190800.222527-1-sdf@fomichev.me>
References: <20260813190800.222527-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add explicit padding before launch_time so xsk_tx_metadata has the same
layout on 32-bit and 64-bit systems.

On i386 and m68k, the old native 32-bit layout put launch_time at offset 12
and had a natural size of 20 bytes. Using sizeof(struct xsk_tx_metadata) as
tx_metadata_len was already rejected because the length must be a multiple
of eight, so the straightforward use of the interface was broken on those
ABIs. Userspace could still register a padded length of 24 bytes, though;
mixing the old and new layouts then silently reads launch_time from the
wrong offset and misprograms packet launch times. This intentionally
replaces that incompatible layout while the interface is still new.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/uapi/linux/if_xdp.h       | 1 +
 tools/include/uapi/linux/if_xdp.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 23a062781468..50d67df78911 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -149,6 +149,7 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+			__u32 reserved;
 
 			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
 			/* Launch time in nanosecond against the PTP HW Clock */
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 23a062781468..50d67df78911 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -149,6 +149,7 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+			__u32 reserved;
 
 			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
 			/* Launch time in nanosecond against the PTP HW Clock */
-- 
2.53.0-Meta

