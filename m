Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792837950;
	b=RSqH/Ms37BHXZex/GdOlltYxw+qcEy7LSeudbf6nH7OC+fSz0WQQuSYy/CowJ5X+5Pyy
	 IlFRvKotQT9D/SzIs13TkXi50Bqu7TBhng6oIApi+JY4/mOqX6ZNYGgr4ur4ssy4uoX6v
	 cvnzg2UUS27/Awn94eusAq6LSe5s/iRD9PbbdoQglGPsBjiFDHDpxQIQFW0qnshPdc2Lu
	 0/yP0NCtGQjaSdMD9hXyfaKgONg+4jKAyQbSqUF3qt4E9VVe5py7VNPRQNqHaM8YKVw8O
	 xmbZR7tQ6YaI3ihDYlOu5XzKYXVkCpYKLhKfZPg+5JUeFYjxYKCy5AeQotyk+2Z88ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792837950;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=by5k9Rwpd3Lb929kxnzIlO4/xIraDNSa5LNfIcf1c7w=;
	b=yBHdIkuU3G+Coc6Qf7NnPzLuOvYZ8wgsHcgYVhXdOTKo+5csRYHqQesl0E7k+Muu2kK+
	 U0lBBMQ5NgHiqCwlN8DyNO/uQ+1WaXVIGfylhcyXK9/qT+Ll0WnmFOlsfvB/BYO1Q9ljd
	 v11N7O3N+4AnWqRkzSFKypuwyNCt2HFG3Mtq653hToQdXsiZKSzd3YHB8BN5XW7KeKQmH
	 YyfVn0sB/SV5/K621TWM3uemyB3UGgKxmED24RSmmbwZ9UxCvEkahT5AkyMUYxGoATqMf
	 IRa2GdISISBrQMMft2I6p3Hj/IB8+K4A5pNfjwd+8zWaRRu5oZyHKj7qOeSf46fXtmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=mmiELwFI;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EDE606A31B;
	Sat, 24 Oct 2026 10:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89EDE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=mmiELwFI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792837943; bh=by5k9Rwpd3Lb929kxnzIlO4/xIraDNSa5LNfIcf1c7w=;
	h=From:To:Cc:Subject:Date;
	b=mmiELwFIw3xoTp4Hjx8+WOk24cx7HjEDZuMMWZOgKfIHidvGPgTWtTsJ1T/5ecGBR
	 raDceycgdomxjVPsh2WJvSBqMjwqBv1+eDUkg1SzP+EA1OoE4gRh7i7mkmDuhJXUx4
	 HDuZc3WrYftC7sx0AqRBImC2bXQUaib4tEIthNuA=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 81485A0D; Sat, 24 Oct 2026 18:32:20 +0800
X-QQ-mid: xmsmtpt1792837940ted38oxsm
Message-ID: <tencent_43A65D51143E18518EA968DF9323694EFD08@qq.com>
X-QQ-XMAILINFO: OOO9dHjlsLs7JqcpGfDwOyvxM76Y4MtmMEynPxk+fpDtCR8etUzE/RdOL7ZFdT
	 /b2p+++hyIaWTXP2wczGr37txuTP+GGs8P6zeUU9OG6d5B/U+EiyjQ0hgqwRfyN+Wbc87VTpMjFZ
	 uuFKwPtYdehH8lOPG5v7rL3O5V3ipvW2Ma1Z5TFzpyrF5LCoWZWzAKA8FoM9QtSG+DufATpQs9iw
	 OudJeldYG9EAWfjg2/IAjLa6Pyoe2rFNybQsQlS1Xs6RqHOCBHvZzJwFMHBRmVCturSF5sNT8sXl
	 txvfgA6fRJB12OSsnD6GXm32Lv3FuIyObI8plHv2lfwRLGI2yG0eneg+yGt98fCUqSnEFRqFeuDZ
	 einR9OQUFkWNDT1JVihCSdfiTQmpHH18LdsYIKxyBprDCFO7pPVVaUIYVwtsSpar4gl6OyazwA4I
	 16VSlUnrZKi4kQQEz39QFw/YJa/fKjQAIt2bxA7hXTqt2LLPChEMiDa+iKc128dyJOwExXtJAY55
	 RONJZVep3moxXmgaOxVZtt4cNLXDATwZ/xA5omNyKQrnGBd7EfEGiYmvk9R9k98Mhts6A2DDVKQi
	 SHTSFTeXVPWebV9S39UALBq9QWwnSfaDIQq6VoYB8Pfm2Lfh80KUZbq7qymCyKS9tzQrAhI1fOf/
	 lDUguPEPkK8J5izTX9OHuSdFD7QLxDUCzrPFXJVydCP34JowSMzA1G86usZyiUj2I+FlVIv7eeWi
	 JhOpIPlmCHOiKkJrzJorZvItpTzMrk1e36mMXFxFEi66pOPhM3IkUrvpjotZXZCcmuxUDNnAWOux
	 Ny0c8lyICbfSZSn99gaWhgAEpBdafsdpmB9OQwMtTPFPRW4pvWHR51gSPCM/oD2fZY7D/86X6ykN
	 wiv1jBu0t4CzfNZ/iIVBiN1zVOtWrmCtczHvQMkQPjoJNqOZMQ5q/5w9TIlUCepKp+rH92NjIDIT
	 UBoLMUoap4tmpDHNoOKaSdEuleVh3tHfhBBbGLsW7X7mMQ3hFaiJeD01SCwUApe9H0XJ7dSKoDOg
	 tfJjScWMDa/ZA+nwSFrqpxz/c2EoM2LAq9ZFyN+IWcHPKjxFBdcnMiWrXe+qWP8xcesQSUnh9lZF
	 qySFz2qMHTK5/Bc4g=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Guikun Yang <yangguikun19@qq.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG net] mctp: sk_buff leak in mctp_dst_input() when mctp_key_add() fails
Date: Sat, 24 Oct 2026 18:32:20 +0800
X-OQ-MSGID: <20261024183220.64968-mctp-yangguikun19@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Jeremy, Matt,

In mctp_dst_input() (net/mctp/route.c), the SOM (start-of-message)
branch allocates a reassembly key, queues the packet into it, and only
afterwards publishes the key:

		if (!key) {
			key = mctp_key_alloc(msk, netid, mh->dest, mh->src,
					     tag, GFP_ATOMIC);
			if (!key) {
				rc = -ENOMEM;
				goto out_unlock;
			}

			/* we can queue without the key lock here, as the
			 * key isn't observable yet
			 */
			mctp_frag_queue(key, skb);
			skb = NULL;

			rc = mctp_key_add(key, msk);
			if (!rc)
				trace_mctp_key_acquire(key);

			mctp_key_unref(key);
			key = NULL;

If mctp_key_add() fails, the packet has already been consumed by
mctp_frag_queue(): for the first packet of a message it takes ownership
of the skb via skb_unshare() and stores it in key->reasm_head, and the
local variable is set to NULL.  The failure path then drops the only
key reference (mctp_key_unref() -> refcount 0 -> kfree(key)) without
freeing key->reasm_head, so the sk_buff is leaked: neither the caller's
out: kfree_skb(skb) (skb is NULL) nor anything else ever releases it.

mctp_key_add() can fail in two ways:

  1. -EEXIST: a concurrent packet with the same (net, src, dst, tag)
     won the race in mctp_key_add()'s duplicate check.  The frag_queue()
     call happens outside net->mctp.keys_lock, so two CPUs processing
     two identical SOM packets can each allocate a key; the loser fails
     here and leaks its skb.

  2. -EINVAL: the socket went away (SOCK_DEAD) between the bind lookup
     and key_add -- e.g. the fd is closed while the packet is in flight.
     This window is much wider than the double-SOM race and does not
     need any attacker-side timing.

Either way, each failure leaks one sk_buff (the reassembly head,
including whatever frags it has).  Repeated SOM packets racing a close,
or hammering the double-SOM window on an SMP system, leak memory until
exhaustion.  The packets only need to reach a bound AF_MCTP socket on
the local machine, so anyone on the MCTP bus can trigger this against
an mctp-i2c/serial/netdev interface.

The same shape is handled correctly elsewhere: the !SOM duplicate path
uses __mctp_key_done_in(), which takes key->reasm_head and kfree_skb()s
it.  The fix is to do the same on the key_add failure path -- free
key->reasm_head (and tail fragments, of which the first packet has
none) before dropping the reference, e.g.:

			rc = mctp_key_add(key, msk);
			if (!rc)
				trace_mctp_key_acquire(key);
			else {
				kfree_skb(key->reasm_head);
				key->reasm_head = NULL;
			}

			mctp_key_unref(key);
			key = NULL;

Checked against linux-next (2026-10-24, net/mctp/route.c): the failure
path is unchanged.  syzbot has no MCTP report matching this; marc shows
no prior report (the usblib series is unrelated).

Found by code inspection.

Best,
Guikun Yang

