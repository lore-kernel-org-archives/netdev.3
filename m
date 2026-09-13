Received: from mail-ej2-f6.google.com (mail-ej2-f6.google.com [74.125.228.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75637701C
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789296175; cv=none; b=ljFXQhYgLIR1zu9cLQzPZA+92ElJU0/7ZBe1kNsmiQqzQl8c0h046tEFLFmwLkEbMnPkMxvSiYX6jhyiw2erOmbIunVuyTfiz2mnsgyrOaNp3I6YTp8awCtZDRNEeZ+w+5rZ2LKxAF/k0dxCBfxB6jYDOqdIc+4mJzgMnEG28AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789296175; c=relaxed/simple;
	bh=Hgj7etMDcCAJvV15w/tbXFhz6t0NQuJpjZlontCcE+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoX7O5g3+0d8yhaxYnKoMKLEjhEkkX1HAniwDd72HPYdxZcMal+O53TBzpvtebRjDGMVUsh1SOLZbawc2C+eFoukQ0WIP3cuh9sRIX9fFbCrgxm8jU+3YMzJ+QaPzAeiS9cDsOHUqPIFu300m/JGFZOtkPw9NddZadK92iIuBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=LlWu4H64; arc=none smtp.client-ip=74.125.228.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="LlWu4H64"
Received: by mail-ej2-f6.google.com with SMTP id a640c23a62f3a-c294716dbf3so174877066b.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1789296172; x=1789900972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L7E6Jghy9mgdjP+MNRkB5vpWmg9D4fAqbUGCwdvSH9A=;
        b=LlWu4H64sijtqwvN3Ptqdhc+cOGNCMWNtLhJJ/dILKk2H40UNZSDL/irzxZ4jLiTJq
         DmlNYek7sNAHEvF52/cX0clvKnZFkRvpCq6u4DXhrT1tH11JxushNkRcZzxR1GFvVss2
         VKNjtf7PD5f5wYt7aMLrw9OdioU4BeeMLkjGbSFqCOmCqUdDiBUVRWv0/Ql6PDdFF7M7
         Z+YmV3jNU3/1SvcyShAnMTori55OmCjo8RL//yYXt4PApO9RTCMRyBd40KD8FkXg5Kn5
         ikfJEzBrcTzI1W2T/TpzG/kuI2PMIStr6miwRoLZXH8b4kCVxh/yhrezt2lmrYjsqzA5
         J0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789296172; x=1789900972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L7E6Jghy9mgdjP+MNRkB5vpWmg9D4fAqbUGCwdvSH9A=;
        b=V+rlvMSrkpP4WeaIdrmLiQx3Qj7KNpwDsWLBR03e2zJFtBSenAP80yWytri0ceV3xf
         A9ulBoYIgDr+LUMxQEHv4kHNmly2ciTnYuGADKGnNP+Bz7LWbfNwnRGYzRUl6np66nZK
         iu89MkzSIlong9e6BbN1QT6iTVBR3I/R0/sXWXM1WDPOq7GGAQG67P1olHF9DjEuCxY/
         qung51i/gPn7p1+KagriZP4nrM6b28wQ2YTz6o+HpuFC9pTv206QkymXCxQYJjpL4fdi
         3A5TUpLbLqV815JN3v+LPVtHyD3rBPxmGHg6dIXwqiJuX/I5iP2ijgi7WmMlD9H9Np82
         s5fQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8GlN1Q8xHFIfsFhpUZoNTyKf0rLKcsbIpEsnpR8gruR4iIRk9fGwHvXByvkuYc04VWTGiHZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++kWCFrar56QZ+Jm3aKphuO81iJfsbpiTTYbW4EDjxe1JDfhgraT
	q+U1LeW+AmNvbOZIOK2ks2CAMW9kNsm+gcNNP3xTZfezI2dY7kEMh2OCC+Om0+Mn8Q==
X-Gm-Gg: AYBFou2uJ5jr/klL2x5hZ5kuj00W/pEKRHmyDXZ7i8K7ORiEPA26zLDFhqRD7YyuoPQ
	r29Mv3YOVde1hsxLnblxenqUxJXgl/FWCHaAngAIzLzWQEWAA1gJr5ngQ0X8kZ2SYKPxNbzCpx1
	A4gcxFUNrm+yEweDSLC7r9aJz8FL5fuHxRlXWoVRF2KyH6ennoC6JUjd+htsdbbvJKagFc0Vh5E
	w+1V7x8hKJRxGN/An7tjHUnncyfjz9HiSA1B/c8aXmA90DFsdUdz1jQsETMb0kdGrtT4lJmztak
	rr/puHGVnHoSl0E44yeUoMChzCDfk25OJTUuFoVAbjVsC3ET56vGZ26BgmbewGKtLG+Ootla1iX
	fZnwNk4FLAWCuMVoMVUrRscXOGtTKjNaVJqf0dyR8cv2wD2Asb9ye+UCjmxVYVOHpqQlppkX3fU
	oGD3hm7nmckzx8MJZWpZ2mmfbv9bVvtou41txBXkCsYyXQpS6JmobtEjetWQMDQj9QH5H87/G3A
	aUchVsk0+1fn1Zc79aWqNS7Ea7YrKWYhgAi9KHeK52Wm8gMXsWs/aGDZQhm5vDC+HIr3VXXV/6Y
	WEx9Ukwo/zbbTfWNhZgdtuvRhK+gvTizcgZxThe+FCjaZfVJNNo+WgyPD3BD7QUXOtuwovaCz9l
	bH84K3Q8+tO09n/k5p/Q5RTIAhJjUkohSYyKnRi9wYJpFNv5Kx8FdzcYNfTfpSGaeagqq/f6QOV
	n4K609w+xEJVgKZBt0weNakwA=
X-Received: by 2002:a17:907:c708:b0:c26:1691:b36e with SMTP id a640c23a62f3a-c2985880e9dmr342461566b.39.1789296172284;
        Sun, 13 Sep 2026 03:42:52 -0700 (PDT)
Received: from Desktop (p54aff833.dip0.t-ipconnect.de. [84.175.248.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296605b438sm278678266b.26.2026.09.13.03.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 03:42:51 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	wenxu@ucloud.cn,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com
Subject: [PATCH nf v2 0/2] netfilter: flowtable: correct and advertise the vlan match
Date: Sun, 13 Sep 2026 12:42:49 +0200
Message-ID: <20260913104251.648421-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906141947.480524-1-julius@bairaktaris.de>
References: <20260906141947.480524-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nf_flow_rule_match() builds a vlan match for an offloaded flow and
never declares it in used_keys, so no driver reads it. Patch 1
restricts the vlan key to the tag that is outermost on the frame.
Patch 2 sets the used_keys bits.

mlx5e is the in-tree driver that reads the vlan key. With the key
undeclared, __parse_cls_flower() installs an untagged-only match for a
flow whose ingress path carries a tag. After patch 2, mlx5 hardware without
outer_second_vid support rejects a double-tagged flow instead of
installing a match that cannot hit, and the flow stays in the software
path as before.

An 802.1ad tag is neither matched nor popped, before and after this
series, and a flow with an 802.1ad tag outside an 802.1Q tag gets no
vlan key after patch 1, as a flow with a single 802.1ad tag does
today. The pop action for the inner 802.1Q tag stays: mtk and airoha
ignore the vlan keys and FLOW_ACTION_VLAN_POP and accept that rule
today, so patch 1 does not reject it. Matching and popping 802.1ad is
a separate change.

Patch 2 is tested with an out-of-tree driver on IPQ8074 (6.18): the
driver reads the ingress vid and offloads the flow. The mlx5e
behaviour is read from the driver and was not run on mlx5 hardware.

Changes in v2:
- Name mlx5e as the consumer instead of mtk. mtk_flow_offload_replace()
  reads the vlan key only in its addr_type == 0 arm, which a flowtable
  rule never takes.
- Add patch 1. The else branch of the second encapsulation block was
  also reached with an 802.1ad tag outside an 802.1Q tag and described
  the inner tag as the outer one.
- v1: https://lore.kernel.org/netfilter-devel/20260906141947.480524-1-julius@bairaktaris.de/

Julius Bairaktaris (2):
  netfilter: flowtable: fill the vlan key from the outermost tag only
  netfilter: flowtable: advertise the vlan match in used_keys

 net/netfilter/nf_flow_table_offload.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.53.0

