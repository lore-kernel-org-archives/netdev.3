Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106791;
	b=kGc5NTeIXbh+SB/psgqrjXY3NuWZLvYAqzEKz3FySKTslhSBtU+0H7WqqFWHjQ1R6aqq
	 sdR4D00mlywvcFj+m5kwCANV7tRn9bgDMyBdnT9IfHnNeMyUDxRwjvj5dwDt0a1BV/bLN
	 6CoH+WTepQ1AvkAPog6dBk7L4iteGLuLINAar4dt1lOvgdjlMNwuoG+wawN4fIseXSAip
	 BJYwH9pMVBH1kghzdXVDsa/Oox7Nn2xwTPl7iVstHy+yIbhkZBdLPyVToFqgmZC+063hY
	 kQTy6QQLFQbcVFNowDDTqC7s1WmH+4k7SFfNnUmJKzC/ULQhagWsBDsuB6vkdb5ZRNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=NLb4nDnDa6CheKrcmNiCI0BRgJPIlEmNmuOLfa1pfGM=;
	b=I31odGVkGlsWHVatx/4WOkLYP3MCzbAXLXyKRVnkonc0Bp9ngdicTaEg9/BPghsBXFSM
	 2hhFDk5eWKC6BcZAxSjzvTy6vciUCKTLXyuegfkAuEhh9QXdBwD4aMk72dEJtCu1HSU9+
	 B7ARZI9PhbBmEA6eGnhwfzQJbfWOF939Gsys+gy54p05rKto3J7ELGZ1hjblGBSstorF1
	 ihJKLZvdWY0THlM6rOIfZaN9bGJEmaerLqzXB8Q1KmcLSLhOkqBkevdmjctG4SIwfv/Z/
	 gQ6XQ071hGVC4Arqa1jDfYIl7WoMGmCE+hwJp+6K+Q1PcyPKE7gaS03U4CJbAEpKWRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GdQnafCf;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AAC606A325
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9AAC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GdQnafCf
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a17a332ecso569587eec.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793106790; x=1793711590; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NLb4nDnDa6CheKrcmNiCI0BRgJPIlEmNmuOLfa1pfGM=;
        b=GdQnafCfs4JjE1bf5swyZn+lUdfkEWIe19XaOfaI/jr6nZJrRlM6EDaidtXyggEWzn
         z6mqlIb+cs/xO51JFD+8ZiFR2wAQvf8Dlrvh7feSj/iyZtu5rSvjsX1g3WFw354kr6BK
         4DcL4gBDT+Er/iQ5G3sLJbNJeWLJYv8+4YD5JrZiUDT9c1qaWkCG5dWJp10g1rfT4x6R
         E2ncrHWrcjzOo+gNaB82xl0fyCHWwBzbmGDop1K2JWsasCX25ZRdaDtihYxiOYWIjtSi
         Oo0KW0aKkdsirAuAo4RnGtiqb7evofLpBW4k3c4W+XIT7MgRamX9jVfkGGbLyvFVfEgc
         8Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793106790; x=1793711590;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NLb4nDnDa6CheKrcmNiCI0BRgJPIlEmNmuOLfa1pfGM=;
        b=kWv3T53QrYxNTN17o5861X4WVUWpNCq6BoHtHSylwKza21ampmhpz5Erw8EP+EeHm2
         4uYItyPc2CtWc9igbHqsHaWouzTIlviv0sdb3mrqvz2p+DFZIWL3+Sgpk+FxUy8RUdd9
         iThjy1SfRzIsbzbic4mFb+61Hm/KAaXeOC7R8SREFSX6JvFags9Gd8An6JCAlnaKUhrh
         Us0HtExXqZ0f+nZMWe8trw5N4DdDjJCIpEwlfn8+x8YjAYxFU13gFecoJe77gU5toINg
         1wWileJqDHuRC/dOVoxt+CSYD55imIhZS5OpPjnzc349u6Y3m07Ab75S24CTUL/NP7x2
         ttZw==
X-Forwarded-Encrypted: i=1; AKwUvBwNHHPAEbZt+obrrYLhAX6TR9tvB0CjBJSQz8nIUH5mLW9L6CCkabrxPhSu+vdSicBRfC75woc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxyWSiqYh/cATHWNwhz3jwIvJKsmgYeLYnP/vA3vdI04J0wgPT
	N1WSlCRemAVwXT6qqsiT5zpYO5TqbG7oVx8gD1jNZdHLgrkOtTjLK4eY
X-Gm-Gg: AYBFou3CO3IVOwsrNwCP2dVgeL4qpROJ/xxDrQZVgKgJ/4cIZYWZR9yFUTaXTcTUzeQ
	aX5UCVHPqXGzk5FGIvtX+FjduINp61OG+g3ElQpH4HeuoqRSgPnE/Li3mSMoYHDlxYGCzyooLKe
	mfAov1aj1teLYoxxVWF30ofqFsN+QaIX+W9RRHM/UFu6AQF/1OB0v8tJnD/JBQO+hPlIB2Kamv5
	c8Wiv6jz1DpNT/eyBOkTRktOY78oHGzLqRsC7dO2Y34cxbbNGVRMjjYSWbmLqehKpfGV3o3PxaN
	QdiPruaAGIVd3Rj5rgTQ3Nseo5A+44pccvjD1L67hmkv8Dv8BF28MBbQctm7004shMYFL96oUhe
	AterJ73fGuP9+gvr5i/c7CQy81rFliV/hStqUxkcAItGpxJxViSgyiIM/Kfwx5t3/wlLyrubM11
	CXDEtCm6PFUDVYz751bhfht+H5oJ7re/wD52Yt+lJL0pBAsvJ+36AfeIRRwMDWkyDcTGgHdE1US
	/e6q3Wfgicr7wFJn2WVXUJf99lhAZ8eS16mvAcVgauuwHUmtM73KGc3wWy5wsUOQev25dgfy1Hp
	Wl2sq6TfDvI8NRylZA==
X-Received: by 2002:a05:693c:88c1:10b0:367:5e31:ce29 with SMTP id 5a478bee46e88-369e84fe37emr14011879eec.20.1793106789881;
        Tue, 27 Oct 2026 06:13:09 -0700 (PDT)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a002a486csm19339403eec.22.2026.10.27.06.13.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 06:13:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH net 2/2] Revert "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU"
From: Esko Mobius <echoowall@gmail.com>
In-Reply-To: <CAL4Wiip=TkP2hmOFR-1Y-CU4rYHY_q=TBDhK6RmTj9UEMQ95Gw@mail.gmail.com>
Date: Tue, 27 Oct 2026 21:12:52 +0800
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
 netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 regressions@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D438C59D-09D4-4008-9240-18DA0ABBDCEA@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
 <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
 <e25fd292-5391-41fc-a324-0ec260828415@linux.dev>
 <CAL4Wiip=TkP2hmOFR-1Y-CU4rYHY_q=TBDhK6RmTj9UEMQ95Gw@mail.gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

On 10/27/26 1:45 PM, Jiayuan Chen wrote:
> This precondition does all the work. The server only learns the PMTU
> when it sends a full-size segment itself. [...]
>
> Please re-run the 6.12.107 case without seeding the PMTU.

You are right. Without seeding, 6.12.107 stalls the same way:

  kernel        PMTU seeded   SYN-ACK MSS   1 MB upload
  6.12.107      no            1460          stalls
  6.12.107      yes (ping)    1416          OK

My reproducer took a shortcut there. What it should have modelled is
our production setup, which is the masquerading relay you describe:
the clients share the relay's address, so ordinary downloads by other
clients keep the server's PMTU entry fresh. Modelling that directly,
with no artificial seeding (cliA downloads 1 MB, then cliB, behind a
firewall dropping frag-needed, uploads 1 MB through the same relay):

  kernel        SYN-ACK MSS to cliB   cliB upload
  6.12.107      1416                  OK
  6.12.111      1460                  stalls

So I agree it was never a designed mechanism, it is the side effect
Eric describes. We have since added MSS clamping on our relays.

If it helps, I can send a v2 that describes the masquerading case
instead of the seeded one in the changelog. And I am happy to test
the net-next follow-up on this setup.

Thanks,
Esko

