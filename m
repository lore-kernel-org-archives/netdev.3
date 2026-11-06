Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938730;
	b=txE7UnvSQLe/Qm3NxzNEYsAYknwL+MTvJw40tx/kDcP1BRQLIv+WgT3CAd1VwAA/A114
	 yzbTxX1lj+IpqkmTe4d/hvJo1Fv9NfHZWM/ZbswPVfuDVY+OB5JL/1QoKqKh+85bnV8Nj
	 coRZKSpvgY5QvH/nqIVR+LzldTxkedXfVmtL0qkk8QWa02chT3aV/Xawe3+KUiDgLCy1A
	 s0H9S0HpdQUsQKz7qtbgzxSoq+9c0wtz3CeDZDsKCQtthCjp1ncNl+gAvlxahnX1a5Wbz
	 RR+Z3I9nCxCLAwc+07wEjMjYupomTg5uGc4W8GAr5wxCk7JmXpp1/CJasUGSfoKx73Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qkRXBwd9VuNyjRdV31nMFJ+5eNrq3IUMvPVOYqoi14Q=;
	b=gMepD1eFEKsSFCHYHjty9z6yode102RET6+IhLKbizD0rbRBR6T927fzRWYi0jS4T2hS
	 iLmNDbFZasVM9T5bPpL7W2o3/75IYZ7y1c+ZGR8VVHLlLeFj8xIA7gichi7hfG3LLCGkR
	 cSXlKPjmKcz2o/eKl9v0nRWF++6VewWScJ93rHL3k+KyNYCFE3NaDllOXpsb9GtABZQeJ
	 cmvKqpHDU+xyS3wH5GKd/lL1WTA3eVq6FjtDO6/V66z3LjsGsVD9bj+5VOkmxHMCAbqTR
	 uL5Pg05EHW3mPTyis9x/e99cZURVMycr5L6KebbuiYVC6fMy1HN/ifGhCvVsAHvMomQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V90FeVQk;
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF6A606A328
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 04:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCF6A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V90FeVQk
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so1283302e0c.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 20:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938729; x=1794543529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qkRXBwd9VuNyjRdV31nMFJ+5eNrq3IUMvPVOYqoi14Q=;
        b=V90FeVQkMj2BLV4zQCiILHXjn/g8I/gaWkVwa1xE6z95gmA3+otHlguHrKYyYK3e+h
         iGm0un6Mt3sySEkdsHg2tE4O+kow5pqBZ2jxrtesOMyzJFhFMVXJ66XPLEG0l1jktTHU
         jTqNxXVhmQiVWDLk/VEAe0QucuyFVY1BWFCP8c7ZI6Dd7YgAMuiM9OgdWkuJaIzSt1+5
         X4Z+UZGRGMDj7HD94zLvOltmUuADE8cU5Pz5UdRQzGy4jc2cubC5hSS4BzZT4Y97yomx
         zEpB19L9lZlBkRPyRQiNZyGXUIpTEYeO3OeoAQ6LaFprsfRHn1Jsyoa3CVJksKc9jKtJ
         RzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938729; x=1794543529;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkRXBwd9VuNyjRdV31nMFJ+5eNrq3IUMvPVOYqoi14Q=;
        b=uSvsZ4crqx+dVOeF5oUIoy6Vs/aF+SkxCk9A2SsNz+HG3bMmlhOzC0lfx7mu2Gksus
         LDGt+hQLvCEPxSV5lGjeh10E8QUHPVAyVPFDdtDVwtnLIS1dEZzHylRFXzvQ+BmYptST
         PhNk6OhnLgzproedDVX3SOFnhfQipWgiTdEb++bKLlQZb7zcjxcErVIU5sddWpXWrypg
         2eP6qdG+yS2k2kTZ/srYyWlwLPYrFaG9U7q1hAK0rCIrd+umKFFopInS0j/CLWMPD1nx
         fY9GKCJsN04RromNlhhFssl0aGTxX5PeomJ/px48gzGxvWGwkoTLjUZnBPUcOBTjcc5s
         Te0w==
X-Forwarded-Encrypted: i=1; AKwUvBxCg24FPr8d7uGvPXehgjb/E7gwPu7KTif4rOMhBvTAiGSBxLBVxmtcJWgebpk6ttrTdriKtT0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/A2EV+I7KNzhPFbmhgiP2GoXdy+PfcS4WlKWMTbpY8/9AwpWSy
	vncOpo1tPXMOXoYyYHJjSAM55nxs1pJhB4PtpHrTaUu5KQtzHEesaLwO
X-Gm-Gg: AYBFou35hw1JjDCkDBdBqZ4MVhpqQA5or1llq7LSYGN+0G9we6hgBFE7XrGFQz+Sah0
	KqMewjesbB/8Lp42h3BSSg0QciV/NjZfI6T2Y7AXf8DYs4gcVOwuPAixBgKuFz56rYR7I8QBd3K
	NXhw6uM+R+ABI7k+xImSvuGwYClevMmqJrkkhvHWMg03YNGnc8rE/TNMi6FOmL4wgpyRwXgEWSi
	wLwD0r8I034Ad8Djgg0utpQTtf3YXD1ZtzuvYGnVPnExXAthe2g7r0QSK65fjUCfuF6k+t3wSb/
	2rs/KOek8cdiFigVFsS82DDk5VL8wsnxkeqOhyLpbg2p+hboGgjMP/6iWBmlkRVXCtGmcF7cvLK
	Al2nep08kA92AiagylEu3RAq+bwvTWOlrIvVluW13/P/pTEWnEkGYrPit+xbKsM2wOG6RgusQJM
	QDJWDIJszWs1d4C43gnMY0auNk286JFb4sUW8R3aNUccwvEBRsQYejn2XmYlYotfmnZY1FFBcpi
	9IxoDYueCHWPlSl9rCGNm4C1sUtL6435qGz3LOCUsF7gQipbA45NvT6BCmPdY8s0b+5EvDxd2w8
	c+XLlYvMu4LriZvd/w60aq3z2tyjTmxgFvTdbCHIVLyrb+LvYfS78pVd0BEbRtP3WAMYuXvhBwh
	w/I5dpcdLm3f++R4+lKXnRhtOPd1RQ1y6KbBpKuAZSnySFeyhswvWjK1xJRESntDLazOqFmLSm1
	DENhwTVvt2RostzAVN
X-Received: by 2002:a05:6102:9d7:b0:7c3:874d:60bb with SMTP id ada2fe7eead31-7d2a14b652amr651881137.5.1793938728631;
        Thu, 05 Nov 2026 20:18:48 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2a8b52ca9sm427837137.9.2026.11.05.20.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:18:48 -0800 (PST)
Date: Thu, 05 Nov 2026 23:18:47 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.2494b56c7bdc2@gmail.com>
In-Reply-To: <20261105115715.1466924-3-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-3-edumazet@kernel.org>
Subject: Re: [PATCH net v3 2/8] net: virtio: do not use dev->type to find the
 outer L3 header
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> virtio_net_l3_start() decides from skb->dev->type whether the frame
> starts with an Ethernet header. tun decides it from the IFF_TAP and
> IFF_TUN flags, and TUNSETLINK can set the type of a down tun device
> to any value, without changing the flags.
> 
> On an IFF_TAP device set to ARPHRD_NONE, the outer protocol checks
> look at the IP header at the network header (ETH_HLEN), and never read
> the Ethernet header. eth_type_trans() then sets skb->protocol from an
> unchecked h_proto, for instance ETH_P_NSH, and the packet can reach
> the skb_under_panic() addressed by the previous patch.
> 
> On an IFF_TUN device set to ARPHRD_ETHER, the checks validate an
> Ethernet header that tun then treats as the start of the L3 header.
> 
> Checking in tun that the device type matches the framing is not
> enough: the type is read again later, and a concurrent TUNSETLINK can
> change it in between, since tun_get_user() only drops packets of a
> down device after these checks.
> 
> Add a has_eth argument to virtio_net_hdr_tnl_to_skb(), passed down to
> virtio_net_l3_start(), so the device type is no longer used:
> 
> - virtio_net always receives Ethernet frames.
> - tun_get_user() passes whether the device is IFF_TAP.
> - tun_xdp_one() always calls eth_type_trans() on its frames.
> 
> Fixes: 288f30435132 ("tun: enable gso over UDP tunnel support.")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/sashiko-outbox-198573@kernel.org/
> Link: https://lore.kernel.org/netdev/179387332014.488856.9111956413610107951@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Makes sense, and easier to review stand-alone.

But if having to respin, squash into 1/8?

Also, to avoid having to respin too often could (now that they're
public and archived) leave the self-tests for a later series.
