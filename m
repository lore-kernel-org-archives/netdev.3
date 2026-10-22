Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693083;
	b=hy9SCz/n4Qjvb2pldJQaloVDxsYHW/7bezGIZ2WwCSpfsuimS3vIsEZxR1huY+a86Fug
	 +gNDRuWDToPhvn8z48vWpSxIyGOjLgek773+M5hDQLsbcv+Xw3OgxseVDMIlcmmLKRNPq
	 6tcN8uY0jDh/fza/X1Dmb+grxeK52UqMakPUH9eMl9Wng2vIvnDmxszud/QoEW7ZWAjU+
	 OPlQo+ITSukK/4aHmlX5qg4Uhs4htBjiqQTofmUgxh+YVtddKwAFcz6sQcxB8+2yFIcpu
	 Ghx967PIxSE8y3it9WYppOR/I6Tjkls/qyCC+MUQwngS0Mdtg6QdC9xjxIl9kIbrr9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FF4NKq41RnOw/zLUVvch7uhHlKySUlKWSKEDV0M64cQ=;
	b=rltk9g3dnVLU2G9IGKYTH7sKwOlMMQpTgyV/nBDCV5Y2iiBYrtoQ1ds6XZtbba3BHcEF
	 c6WoZ7pT9qx3GguZysPxw+GF0V37h2g4zVTfP4FmNpWkPjy72rSUIY25hYIgQF/hJ3SsP
	 hREnr0Sdd+YxcCLoyMF1UIVo19j5ThpK/3ZtKzW2uFD3mC/P+Sfm+hC1QOAHaEWhvFLNQ
	 kFkyOANMBykv042n8UG69Rjj+hHYRl2mLtIXuBL00usd/AtBWuDieWrYx+8pIvAt2T/uG
	 XJGe0tPKBumvFe+zT4GbbIKp3a+I3DDYbH9L2HXA9HH401zJPatNb8gqo2j54JTrEEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=NTgPq0I7;
	arc=none smtp.remote-ip=209.85.216.101
Received: from mail-pj1-f101.google.com (mail-pj1-f101.google.com [209.85.216.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A91606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5A91606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=NTgPq0I7
Received: by mail-pj1-f101.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so67775a91.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792693082; x=1793297882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FF4NKq41RnOw/zLUVvch7uhHlKySUlKWSKEDV0M64cQ=;
        b=NTgPq0I7/byCOjTa2u2mMrggaFqUlYpn/c6206FLgwLBDZJ77HfThhogmfl3FdwPDo
         QUrd5C1DZH6+YxrdNDxSyLQVPrTbf42TXnRzV2E+Q4XROLaUBaR89PKTffxizr9MCqMG
         WU0TL6Vg/RlR8X/lkVpi6SMAjUtjOR7OcRiTXpRfHc6RDpgMN9RVK9fJxOO0jbHtR6yr
         NQbvnXUq87jUmP/FwHADooUoF4syFRaXbmsCayPfyqZTLH7z3XmGo4Gc4a6hWSimMvSf
         jS4RjV7JhbrkdQkuYWv5Z1Na7xHhKoVP+ZgaeMLOmTRMngS6uOZZQIda3iCn+WwoamwB
         fXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792693082; x=1793297882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FF4NKq41RnOw/zLUVvch7uhHlKySUlKWSKEDV0M64cQ=;
        b=aG63CI0wHGKwDTJPFJivLV9plBX9vz2bkuJJzGDkxuWM2z2udDrVGqIQJ+1UPMDgrb
         boHCfoRI4lDYeEX+pYL2CMo6ov9HXJJcOvlkATyWC/vGcnyjphfAgDiQNTiTRfIvLV3k
         nL8+z23iOkuHGVJ4xEkgaw4TmgvZJkS6NSFmysqO9ZTkBL1TNXBD0w4niyHS1z75leDr
         5xX8vs216NSKQzR38FEbdAignVz9wNq0ZIlsog1tHY3Vm80WKo2jNrTws72OZmwwWDZ2
         ShgXV5DAhZCmk2DGbOVX0Okk6jBft9HkPSmNqcm5grE4poZIDJlJLxrzx4ecDYDgf013
         mlRw==
X-Forwarded-Encrypted: i=1; AKwUvBxclu4sKgcUPIj8e28q61XGZpQMVOClkM9SVXZVWLAjz+W3UIKyB2pfiXGxpUliQ/0Br7Ixo0s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfZL8u283iUMssw/IMV+ICJx+Bc9oQmKXC/th0/mMOmh0E5oin
	5m+OELv4dSooP0xN6JjMftRWUoGalc4ET7j/lRW+nfe5YgNsZPP//yNfi43DtNmTcb0RT8t5GbL
	TnOgtwljoVBNMzF+dJdAhG/V0/FHzcGcyfCn6tmPYGpvwJZ1yvoIt
X-Gm-Gg: AYBFou02gc31ElJsF55Fwa47KVuhSlqiB9HXwY96rZArQqVzkby5YPTHzAG2XLSpQSg
	i5Q1uskS+b9bR3r2J/58C9vxjwYN3FMWWd24Xu4az4xzN464C+R0O/vVG4aGdXQ01Kuqfpe2LEJ
	FWZk2uI3MyJV+5OoB0rsLzlDiMrc61OkMt324XAb/1BDrohEWlKe0YbuK3lbMP8uE6rT5gwaMjX
	QoAvbcEAD2KEeVeemcqJeIrJEOkMYUnf/gQ41o0rmcEWcuvCeNRl9KxpEMXwsDrT1xNb/NsxdFg
	zpLdQFCy5PkasC3q9aFN77gEU5rWzkaIH20V2JYMvv43Q1bZMdOaelwyCGCoCQ2cAyDLlpWZHjf
	hxpfIT++/1ZZBH4gUOxQ=
X-Received: by 2002:a17:90b:3c8d:b0:3ac:7f4c:a690 with SMTP id 98e67ed59e1d1-3ad86eeb9e6mr4290250a91.35.1792693081944;
        Thu, 22 Oct 2026 11:18:01 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adc9568c29sm55128a91.1.2026.10.22.11.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:18:01 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 2EE1540309;
	Thu, 22 Oct 2026 12:18:01 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 2870CDC48A1; Thu, 22 Oct 2026 12:18:01 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: tariqt@nvidia.com
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org
Subject: Question: net/mlx5e kTLS TX TIS reuse vs in-flight WQEs
Date: Thu, 22 Oct 2026 12:17:41 -0600
Message-ID: <20261022181751.1349984-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

Hi Tariq,

Could a DUMP/SEND WQE from an old owner on SQ A read or update TIS
state after SQ B has reinitialised that TIS for a new owner?

The existing TIS pool predates live rekey. My TLS 1.3 TX KeyUpdate
series (v17 [1]; v18 in preparation) calls tls_dev_del() and then
tls_dev_add() on a live socket, and the question arises through this
sequence:

  1. A spurious RTO retransmit of old-key data is posted on SQ A.
  2. While that data remains unacknowledged, setsockopt(TLS_TX) starts
     rekey and installs the rekey validator, which stops admitting new
     plaintext to hardware offload. An ACK covering all remaining
     old-key data marks rekey ready before the driver observes the
     retransmit's SQ completion. A subsequent sendmsg() enters rekey
     completion.
  3. Rekey completion calls synchronize_net(), which waits for CPU
     transmit paths, not SQ completions, so a WQE on a stalled or
     backlogged SQ A can still be pending. mlx5e_ktls_del_tx() then
     releases the DEK and immediately calls pool_push(). DEK
     reclamation uses batched SYNC_CRYPTO; returning the TIS does not
     wait for synchronization covering its old DEK.
  4. Before re-adding the offload, TLS allocates the new SW-fallback
     AEAD. In that interval another connection's mlx5e_ktls_add_tx()
     can pop the returned TIS and use it on SQ B. The same socket can
     also reach SQ B on re-add: with the retransmit queue empty, TCP
     sets ooo_okay even while the retransmitted skb still holds
     sk_wmem_alloc, so queue selection may move the flow.
     mlx5e_ktls_handle_tx_skb() posts the new owner's initial
     parameters with skip_static_post=false, fence_first_post=false:
     static parameters unfenced, progress parameters fenced, then a
     fence NOP.

An unobserved completion does not by itself mean the WQE still accesses
the TIS; that is the hardware ordering question. The same question
applies on SQ A: resync fences its first parameter update, initial
setup does not, and I do not know what either guarantees against
earlier WQEs that reference the TIS.

The normal close path has additional ordering. tls_dev_del() runs
from work queued by tls_device_sk_destruct(), which itself runs from
__sk_free(), i.e. only once sk_wmem_alloc reaches zero. For
transmitted mlx5 skbs, SQ completion calls napi_consume_skb(), which
invokes tcp_wfree() to release that accounting, and parameter and DUMP
WQEs preceding a posted SEND on the same SQ are retired by that SEND's
completion. For successful transmissions, this gives close-time
ordering without an explicit drain in del_tx. WQEs posted without a
subsequent SEND, and SQ error/reset paths, need separate lifetime
guarantees. Live rekey does not wait for socket destruction.

Was the recycling fence relying on this socket-lifetime ordering, or
does it independently protect against outstanding work on another SQ?
c4dfe704f53f ("net/mlx5e: kTLS, Recycle objects of device-offloaded
TLS TX connections") says the fence ensures context modification does
not interfere with existing traffic. Does that cover old SEND, DUMP
and parameter WQEs on another SQ, including work the device has not
yet executed?

If reuse must wait, would retaining the TIS and DEK until all
referencing work has completed or been definitively stopped suffice,
including during SQ error/reset?

I have not reproduced a failure; the reuse is visible in the driver,
but I have not established the hardware ordering guarantee. A PRM
reference, or a statement of which completion must precede reuse,
would settle it.

Thanks,
Rishikesh

[1] https://lore.kernel.org/netdev/20260917224355.2288021-1-rjethwani@purestorage.com/
