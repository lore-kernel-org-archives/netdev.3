Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BCE377574
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827489; cv=none; b=eTy1fPULF7Fjg1BIKnYZtjsf5DuEOtmnnELWZD1QSJwAP9Re8l5ea/nv00EiU3F6sAfwHaig+yg/m5OqJXk7pjITF0BlHrI7h/mswvHxGUKoa4FvVY71+yABAXYqaTbjWILHH4uqyPTAeVGFINsMLnXtzB3+G41qYkBH4k9nPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827489; c=relaxed/simple;
	bh=xq8/CV7bWeFFqHzhD3QccJyR+ORblh9hqoRJJiehiP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHMmtK1TpHBbWPLY3iB3w+yYNNbxCxyQoh6edNTlxjTf6iekIt88TALlAJ5fp5jsVN5atkzIzcSNBNotYaGmTASrSIlEiN1K7yTW3G2k8PAficjVKsBUn9f8mbPrOHK5H9At+ya4tO/5ASzboy9sRJ4/i2sVLGFoDLV8UZHRfVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtv4iWf+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtv4iWf+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso2434715ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784827487; x=1785432287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gwIkS8hgFx2QMlyHA6OHo3V+xp+5HZic5vpfeP5mT0w=;
        b=dtv4iWf+pyJNgwkaB5Zz+yTjDg4dznT+xQpA5MfcyTXvtBQMk9MQi9CHCf2yE9PnIo
         KJaM8JmoAzabduGHYeaAT2JHRgrZt7rzwa0j33/YjFXmenhPXLAvjFQsg25nBIX4mSUw
         +PcuxKr7MOKqp0/UdUqf73yiOOEpK+DsoKI5X2OPagQMVXEGTygj+fkrmLYkOXYowCcj
         SeMGXSI6zBsYQ0IqTawmq08uUCmbIqxwaXhaQCMiQS6S8k5hHa//5e0vmD944C38xrrD
         QvGqhkayFpFSpG1C03aDLJz1GMTxaZUF27E6OpOMR+p4nqjjtexG0qUaq3ZykzCwe5An
         RymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827487; x=1785432287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gwIkS8hgFx2QMlyHA6OHo3V+xp+5HZic5vpfeP5mT0w=;
        b=QQKFMm1RRWHLLjNnr7mCM2lXhqwWRdZ3SgksyNVYXdp5xN+yF5JCVDZFb6BeoPj6Zz
         488pVSSbMWPjkiRleqnR4sEzSDvthPP80xC8sdLBqDukstZxj1BDpnQPkuftOY2qt/kE
         0GQemjV1RTO5Ci6RcTJqrZOH8YmtRg8ARSISToeK2FSIYkQU9+C08cgW2NmcMJYXIMrP
         Faiiv1sQ/JgJ46LNhII9TElCp81480mhvdIVXjRqo6zkrWnTr5GH0GBQPwrB6dAdIMQE
         weWVBkLbS/2pIByyPU5eRSEcmhnb6VyfSuuqklu6xD4BuiBj8z+8Vj/aiGT3WarWn/Hi
         pwUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrqonoMQ8udpUBKBfRzvrCsZoLV874L9ek9szQT2WtErwSmBnSDueTb7SqiTblBJNN4geJqZak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1q2dPWRXl3fiyOt3LtmxgM/s7SEYr3DbWWDRZuz42fG0jQcT
	rIGFVyJ7dbR6J0U1eTk6qm4ugp7/cILfgR4CNonZHmkMqEbFicikx2tJ
X-Gm-Gg: AR+sD12W0I2/BpXrrkgQFId3B5lhlTAwWbmDaBW6qjzviuPXDipU6wwMPFfZ7/Dnlct
	qeI3H9PmWmETk/V4nurALhNK30Y2BqvJBgAgEURcnvpe8wKEJnk9IKd1ajormpMu4TOkniOE5Ac
	XyrVKRHqI8CdlDnGvSXjxctRoEU7+6c3UeI1AezPcCHCmh/npKt7EzyJioIjCo4pAS3fRsjjMce
	IsoRrMh0zBu+QzHAcDZ28ZBGQ0S8D1KwoDmcILwqvPijTP1fAsg0gr1Ub36Rh/MvL+qy9M7sG/A
	2vZ3lmoZnvSJ+QvEz73dYhdKx2l/jBSmW2+BOQUFu19fyftsi6VehYp3/WC2AIVKxJbgZhgm6ST
	BzzavrUQSkYoxz5CacGO0Gg2xFkK7TwrUo239JgnxBGYNmec92ds3lo5lbtFAP/jR+um3MBhsjC
	0W+XgJWRFSatYCeCYFyMdiDUe0q96fCleSgyu2K4v4vC3b
X-Received: by 2002:a17:903:1a4c:b0:2ca:cde5:29c4 with SMTP id d9443c01a7336-2cfa709813amr48848825ad.47.1784827486844;
        Thu, 23 Jul 2026 10:24:46 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e5e8esm38119995ad.49.2026.07.23.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:24:46 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:24:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
Message-ID: <amJOXKql1nbskGZJ@devvm29614.prn0.facebook.com>
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
 <CAHS8izPiZ_1aysWG-up6eW285+MzJN17L9QREfVWgRLkdqL5sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPiZ_1aysWG-up6eW285+MzJN17L9QREfVWgRLkdqL5sQ@mail.gmail.com>

On Wed, Jul 22, 2026 at 12:49:07PM -0700, Mina Almasry wrote:
> On Wed, Jul 22, 2026 at 3:59 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >
> > We should either have net_iov or page backed frags in a single skb,
> > otherwise it blows up down the stack. Don't allow mixing in
> > zerocopy_fill_skb_from_devmem().
> >
> > Fixes: bd61848900bff ("net: devmem: Implement TX path")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> It's true that we don't support mixing niov types and doing so would
> blow up, but this is an unnecessary defensive check imo. The calling
> code should not (and does not, I hope) have an edge case where it
> tries to mix and match niov types.
> 
> Maybe a DEBUG_NET_WARN_ON check to help catch bugs in the calling code
> may be fine?
> 
> Also we don't really support mixing different niov sub-types in an skb
> (like IO_URING + DMABUF) afaict, so might as well go the extra mile
> and check that it's all devmem niovs specifically.
> 
> And might as well put the check in skb_add_rx_frag_netmem. It's the
> same situation on RX, we don't support mixing there (and I hope no
> code path leads to mixing today).

Hey Mina and Pavel,

I was able to confirm this mixing case does exist.

It looks like in tcp_sendmsg_locked() when new message is non-devmem (zc
== 0) and tcp_write_queue_tail is devmem, the skb collapsing is allowed
(though same-frag merge is disallowed).

Adding a mode to ncdevmem that sends mixed devmem and non-devmem
messages, it can be caught hacking this in:

/* DEBUG (DROP ME): detect a TX skb that mixes devmem (net_iov, unreadable)
 * and non-devmem (page, readable) fragments. Such an skb must never exist.
 */
static bool tcp_dbg_skb_frags_mixed(const struct sk_buff *skb)
{
	bool readable = false, unreadable = false;
	int i;

	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
		if (skb_frag_is_net_iov(&skb_shinfo(skb)->frags[i]))
			unreadable = true;
		else
			readable = true;
	}
	return readable && unreadable;
}

static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb, ...)
{
	...
	BUG_ON(!skb || !tcp_skb_pcount(skb));

	WARN_ONCE(tcp_dbg_skb_frags_mixed(skb),
		  "DEBUG: TX skb mixes devmem+non-devmem frags (nr_frags=%u len=%u)\n",
		  skb_shinfo(skb)->nr_frags, skb->len);
	...
}


Resulting in:

[   85.908005] DEBUG: TX skb mixes devmem+non-devmem frags (nr_frags=2 len=24)
[   85.908342] WARNING: net/ipv4/tcp_output.c:1570 at __tcp_transmit_skb+0x9bb/0x1030, CPU#2: ncdevmem/278
[   85.910646] RIP: 0010:__tcp_transmit_skb+0x9c2/0x1030
   ...
[   85.915617]  tcp_write_xmit+0x47b/0x17d0
[   85.915802]  __tcp_push_pending_frames+0x38/0x100
[   85.916025]  tcp_sendmsg_locked+0xe51/0x1280
[   85.916244]  tcp_sendmsg+0x2c/0x50
[   85.916903]  do_syscall_64+0x11c/0x610


My feeling is that we should guard against this when
tcp_sendmsg_locked() is doing its "new segment or not" calculus.  In the
zc == 0 case, I think we need to check if the queue tail is unreadable
and 'goto new_segment' if it is?

This is a different case than Pavel's patch addresses though, where the
new sendmsg is devmem and write queue tail is readable.

Best,
Bobby
