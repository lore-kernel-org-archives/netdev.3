Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605933;
	b=V7Cc2VAU9L9MIZy9xML0X3+8zWRTchg3VSKaz5Qc6Y2m0K5V7pctXKgxQsAwIbe8uUkF
	 V/c83fLpOTzfin4V977U88Zao669KUQG+4dEKe7DiUS+5ebfuZ3UBPd2Xr0J1iFJ6BYDj
	 sl331DeBOh4pYsgbzt6DebFP+AINKyZkGne7+lOWC2bF8Y8hrSW2Eamvzcs0hiYoOuOLc
	 9+O995SvF9emGhVWDEhF5Jkj/uwtSk1+W3gYZ3424llAcGu+kgp+r1EnLQLn7XrgKo239
	 bwXrfsnlgu+YXU6puRRtD6skoXXZd39ILwuL/lZLJ7EViZJgnt4GaZ0y073OKkuTWog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DS+qpxy2NKuBUhINnKtH+4oZ3tQEN68OVLg0g7A1lmA=;
	b=IkIs93ZCZD0tNtcCFkeN1MAH3yYSXRdWu0VK58Seh0jjlmOVc0qxbzC7i6C3TBvNrGUO
	 G4fWHqdogzi4IsZBuoUro40Q5OAE8PxKVJn04ZcbK4fgbwMmWq2EfiPXaVb+TOxjT+ERK
	 HIE59c8oEMFAtzwNxAbQX0BqHuYEBFF0thqVVefZBkoTkjuT4FqN2gBjj/WuYFbj7ubt7
	 9l9w6VxPWvTj9I0RcqtXWvyKPJea64/m/OmN8SjXlrVG1ituw/IueVCIY3MuWxO23kuhB
	 6RuQUJ3ilOz4qxq9kkBHUeFuQ4OiWi34+WNvzqeS7z62DkYUQ+QZdrUUXfWAYqWM/dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ii5B2VWq;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3681606A335
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 18:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3681606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ii5B2VWq
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1dfd49525so8271235e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605931; x=1793210731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DS+qpxy2NKuBUhINnKtH+4oZ3tQEN68OVLg0g7A1lmA=;
        b=Ii5B2VWqfwQW5rzOGgccwN0tkdmw/e4rjES1c5Zo92Eo0X5gjyDyp5PY38u63ZPztE
         uVtGhuu47sjcZgNH1Wo/jaIgCeym6Ms8YT9fEnibOKNBnQRdevlo7AO9rtWlYUIJIsqy
         x7i9wy67Yb/MnMKsq9nAG0J+0gIMNOB1eaLKhYtLYHSlrhUXRxA3nZimCsJRByF1QNlY
         RsVQJBPzWToj8ihKGmpCfsecuceIY94Cex4ogp5ahaUKwiHB58wCl9xgJCQz+9Fzp1bC
         Fes9WVUmPxSIFuH27OMYhcrpYJGSU9mA91jOKK6lqOTpzSrK6eb7HK4i+tuWFf9fp5OT
         RGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605931; x=1793210731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DS+qpxy2NKuBUhINnKtH+4oZ3tQEN68OVLg0g7A1lmA=;
        b=Hj7K9StoCvje2VQjhLIO++jzf59Dh/H4XbYujXBPuKbahqBBY4nfrlHIWYRuf3DeFW
         qkQhgXcBHVoNpwLpNKvxjAXKinplewPYsofhnAbDmK18a/5a66BG9RKEOdb/+orANuOe
         H94KDogIABsC+pBMQLMuqC11y2Xhl1QQwwtCDYAoKMvAyKWCOWfRDCifzvHiDpzzU9cK
         uay88TjRsKkSqN7daMo4luAaliskzSkCCsC2KO90vbJ5mv/nVPRWyhS8OAZnnG+cWoJI
         76QoYvvToRVCdNaPHdccE1HvMxC5wUOdUZ1ZQx+Ed45nz04p4+e6DO8dUM57G+bGH/0A
         3kTQ==
X-Forwarded-Encrypted: i=1; AKwUvByFxGKznisQQKnMd7VW06E897xnU6og5b6ZWVggBdEZ+p4/H9h8BYtvuAPb/kUyICJVbs6ccRc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/WlinyDeMN/G3H+/XKg/t1hl7KwnwxmOZeZ2k4JRFN4dQDyNv
	FWOaSvQNkulgvVAwZxbH6/6shktqB8U1778OM4BdJYqWlJtmn9azrFi1
X-Gm-Gg: AYBFou3fhfTSOg/cz/DgMssC85czAkkFH5oAs+yGyj2/0ZzfXdVLW5BlkdpFH+rDYYu
	Yz5tGQrw4/shBv1igQHG7y1VoMi9oJPAvFhJzHnE9kT5wL15w/USmscr1DYlnDfYjjDvzrTVR0r
	GshdoryWWMgcXMuRebPDugRnmUe4ScFhOWZhst1TLxqGBayvcMA5UhN7dYFVT9FgU+EEHwrFhVU
	SAqPe3csdEil+WoQ1PMMaRyqX4k10io286JbzYPHYm4r/rH02sp2+OnXz66qce+xPHp44yskwgb
	cJPuvwSUMThGn+7xmdaoH7IdF41tDnFMZ5Q17hgbx4fRwZDvxSJgyxYHlNy1YV3X6inXAB1bJuq
	utTC+jWb4WylNTJk/mZ9xYtj6qayJt5egC5OSc8k4+I1vHoR54Fu/0BTUKdERcvnzBwEuqOjlie
	IKWMmcj/1J+jMC+Tj4zDmsPlk97+eSR09bFuvUzl4LbhuOKX/YuSlMC0Hreq+TVN0fq1Zva3RoU
	Uy5g6mDAJZCSYa+GOMC+ZOuepa3iS/ZGmorL7uJXRHIhIhYcNIsSZSVJBpddrvjJaE9blodo2gY
	Tbawby+yBbHihoX+RZFhO3rP/DRljefxxV1E4MO5DoUj11fq7WAaqCEOh5/A1ZituTEz63Xdqa0
	95b5mfJlkBAnvBZ/6uPhQMfVkr1X0NTqh
X-Received: by 2002:a05:600c:1d0f:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-4a1fdd14249mr60316635e9.13.1792605930927;
        Wed, 21 Oct 2026 11:05:30 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:e6ea:6401:f04a:ac6f:988e:f33d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd13891sm47007775e9.2.2026.10.21.11.05.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 11:05:30 -0700 (PDT)
From: Nick Simpson <nick.simo@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Sridhar Samudrala <sri@us.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] xsk: document checksum offload handling in copy mode
Date: Wed, 21 Oct 2026 19:03:28 +0100
Message-ID: <20261021180329.26358-3-nick.simo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261021180329.26358-1-nick.simo@gmail.com>
References: <20261021180329.26358-1-nick.simo@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In copy mode, XDP_TXMD_FLAGS_CHECKSUM requests are now left to the
device only for the TCP or UDP checksum of an unfragmented IPv4 or IPv6
packet, not IP-in-IP or GRE encapsulated, on an Ethernet device; other
requests are completed in software before transmission. On devices that
take skbs without a linear part (IFF_TX_SKB_NO_LINEAR), every request is
still left to the device. Say so in the description of the flag.

Assisted-by: LLM
Signed-off-by: Nick Simpson <nick.simo@gmail.com>
---
 Documentation/networking/xsk-tx-metadata.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index f240930ca1df..028564dba43d 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -50,7 +50,12 @@ The flags field enables the particular offload:
 - ``XDP_TXMD_FLAGS_CHECKSUM``: requests the device to calculate L4
   checksum. ``request.csum_start`` specifies byte offset of where the
   checksumming should start and ``request.csum_offset`` specifies byte offset
-  where the device should store the computed checksum.
+  where the device should store the computed checksum. In copy mode
+  (``XDP_COPY``), only the TCP or UDP checksum of an unfragmented IPv4 or
+  IPv6 packet, not IP-in-IP or GRE encapsulated, on an Ethernet device is
+  left to the device; other requests are completed in software before the
+  packet is transmitted. On devices that take skbs without a linear part
+  (``IFF_TX_SKB_NO_LINEAR``), every request is still left to the device.
 - ``XDP_TXMD_FLAGS_LAUNCH_TIME``: requests the device to schedule the
   packet for transmission at a pre-determined time called launch time. The
   value of launch time is indicated by ``request.launch_time`` field of
-- 
2.53.0

