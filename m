Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181CC4322FF
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385462; cv=none; b=TXl1REu4/+fMTjHbNBfwHpLK2yN5y2SS0nj2+PNrMZTPIYm+tp8+U5PNHcgr5X2HnInREXn48EQQacoHUtuGQPuplUtpzsw9kymGNsjCJ+xon1BNOVx1rlfgWs6WZUbzpMdzhYkdtPkfUcyiFgn8UENSyMynW2N2BmzLa9JsOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385462; c=relaxed/simple;
	bh=XVLHkEkzk10HmcpN85IcIiDshOncII3jMxriu1KHT3A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YUC08n+QIvuJbbCxO3NRZnTXcNcbP3L8eyUt7ubu010Gj2l/p3lagwnbXGm8BASmEsDb7CyaOAGctPhfvb9jO5Fbo+z2eH1+BSFg6pHQl+9T9o5ZYX/NFKt21cK4Kg9H2mHKK7fGyDQuEQychM9suagQ3wUZQP+yBUExe7woswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ge60hiXb; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge60hiXb"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81eaf3709b4so28336357b3.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786385460; x=1786990260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lunOkSA+bnZFxf4sFchrb4K8P+Dq8smU8sWPWcH/6hE=;
        b=ge60hiXbhR0BloQiolx+rZN1joCWLevV5F6VRpB2rfP1FAnp0lvQodqSeahaj6oywn
         JwvMXR5kQ1x0RhcNYlyVnGL1taU2WxPQ/I+BQQVn16Zy1he2gJ+heIVflbzlM/oCLKQ6
         UnmGQe6Ngo6Hq+03hW+dECMKeSPGDOXWe8D2Eu37LleQyZnr8rXlelVhNPc0idKwAeGP
         f46Tj5mHUwDBdyZdTxbNAQSfpdsyMBYGUz8508b0cjRj3y3q6p8jX5uopSIG8V6IUCb+
         Nff4ZEJuEA/D+kGicUKdVPXLcBCWAKB35fAsoU2e7fxohWnaZqrxidihtdMX/AJ3DqkH
         yYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786385460; x=1786990260;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lunOkSA+bnZFxf4sFchrb4K8P+Dq8smU8sWPWcH/6hE=;
        b=jTpkQwfLIFND1PujLRN2BFKa8/MMhd6UNT2HRAFk0nCILU7ZVG6LtCjJwqD5z4W13G
         nRCzCt1CTlxPS68hcRRpyTpzUjecw4wZsnhU/S1YjQvID2kVlof1l0FidMeFYYQF5nio
         3AiF1bQGXuT5+//oOGAnE5dQh1BYzZB/VUMmEyD2ujQtDX8jK4FVJoRjns/dIrIiaIOq
         44C64OYTPZPRnAaMFs32Z0llzgrhaVvwpdrwY1MjKLWf/DDQv/riyUsW8ozKIKZ8R6ZU
         Gi9ofoQm/8MqZeiEubSSKra+DS7i4CL2pPlDKc7duHsgtPOhBAhW90HjBqT7kFMJDkoB
         8zUg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6bPeAvYCx/AtSUULsRMIdPO35W8okYWBW76SfCAOoSN+fSG/FzeuCIAGsnFQsFlgoIJz/1V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG8TUIgO8CGoRCldMLQ2Ut/0Ouvh2TNk6VvrP/Og5gD5eZHvIf
	D/ms+HXd00IUIB+EdpwsC2e+xokrZYSBY6IRGTkWIvpusPfsQSxX8rre
X-Gm-Gg: AR+sD11DUO+XtKQ1AUyuwHFMMuEmxmnYuT9Mr+AZeH90+3UH6/HcaR3uJJXhruhNxb8
	/5hTryz/VBaYWCONel5XQ0lmVcL/wfDmZ0URKy5n/FOYDVwELKKj81kLfSEl5G7zjSq9LbhHiyu
	n6RT2lq/gNEgKbHuG42wTqoODDaBAtgpYu7vX92hoEKHG95gp/KuG24Xx+18VbvD9YUyN0ASmI9
	QNiZlihD3jxAMPmZyONw6bfdG2+ZP10JR0dZG9/olB1FqkQDquvVyhg9z4FdjdRlQLCMBSorksh
	Kn0JRZosgabFZVsSXMiHsvXLa2QvMK6kd4WJTlb+adpkgaefZ4ImeainLRWV9Vw6tbpTMM017+r
	gZii+++/5MNWe9MBh+fa5CGRjFBGxICcxXjyaDv+GicWIrPS1buUFw5cQSSoE79POsY9i+QWcoU
	zkANSzvzglSqfaxpixMj9kuLFf9Fx7A9dRuGB88S1y2K+ACPlZJQPzvBGBQ5qegjFu/UfuPdUmh
	LcljPJ6sETLPNYGOzvRpGeR1S5HuFVcLaNLCw==
X-Received: by 2002:a05:690c:6006:b0:81e:45a6:bd4c with SMTP id 00721157ae682-82d2ad9fdcdmr28125187b3.14.1786385459799;
        Mon, 10 Aug 2026 11:10:59 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f09910b2sm59898947b3.16.2026.08.10.11.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:10:58 -0700 (PDT)
Date: Mon, 10 Aug 2026 14:10:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot+30b93b6845b19cc38581@syzkaller.appspotmail.com
Message-ID: <willemdebruijn.kernel.7febf0acff7c@gmail.com>
In-Reply-To: <20260810150447.1220864-1-edumazet@google.com>
References: <20260810150447.1220864-1-edumazet@google.com>
Subject: Re: [PATCH net] af_packet: Don't send zero-byte data in
 tpacket_snd().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> syzbot reported a WARNING in __dev_queue_xmit() triggered via tpacket_snd():
> 
> skb_assert_len
> WARNING: at include/linux/skbuff.h:2753 skb_assert_len
> WARNING: at __dev_queue_xmit+0x21bc/0x4970 net/core/dev.c:4781
> 
> Call Trace:
>  <TASK>
>  dev_queue_xmit include/linux/netdevice.h:3448 [inline]
>  packet_xmit+0x243/0x310 net/packet/af_packet.c:276
>  tpacket_snd net/packet/af_packet.c:2907 [inline]
>  packet_sendmsg+0x28d6/0x4eb0 net/packet/af_packet.c:3134
> 
> When sending 0-byte packets via TPACKET ring buffer on devices with no
> hard header (e.g. dev->hard_header_len == 0), tpacket_fill_skb()
> populates an skb with skb->len == 0 and returns 0. tpacket_snd() then
> forwards this empty skb to packet_xmit(), causing __dev_queue_xmit() to
> hit skb_assert_len(skb).
> 
> Similar checks exist in packet_snd() via commit dc633700f00f
> ("net/af_packet: check len when min_header_len equals to 0") and in
> packet_sendmsg_spkt() via commit 6a341729fb31 ("af_packet: Don't send
> zero-byte data in packet_sendmsg_spkt().").
> 
> Return -EINVAL in tpacket_fill_skb() when skb->len is zero to reject
> zero-length packets in tpacket_snd().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+30b93b6845b19cc38581@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a79e807.01d0871a.3a0d52.00ac.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
