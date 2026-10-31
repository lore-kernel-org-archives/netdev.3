Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793450936;
	b=uFGTbvfGJj+6LP3E+orM1+nIyPcJFr18ApXCt3h2ngGGbrWp6FIDkwdtEoNfpCM+Xx0/
	 tYwkZfyqWzsIHILZMis+9PIuX4+R/eGWkW3s5a0rbv/h++AhQkE7ONZOQyh9Il7+37uZd
	 hx5EuS18zYMtU7pZsVAl312ekLM6UN3H+Ntt6ZZXWTSq+HhfkCnT55BXRs2JkcP1qccof
	 N+EDybsLVJGaQ1TokIuogKQ69akEDXEhbTW8f2NkoLt2GUXh5sWJeUbPde3jAgJ4R3/7j
	 fmW4DA5zXvwIhG1PYBd9v83y45Xj0fWfwLb+FF2cO4B+u+4KSZbv2OGAEKPs1iNB3qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793450936;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TH1d29AZCliQEyGyMsOxICcozWzAriuf3DJT8Qo9/dE=;
	b=E6cY4J29gXkDes7CK/OtotRUc+0yw+T7RRs7DqM9okOdT/piVXmM+2XzkU9SZQAh1PtR
	 03/5h3q81szPKa/b9d3mEw0n23jb5VUizWvMS7rbjgy490+rF4t5rKr1zDr/7R+UTAnCz
	 +TMYMC/BzIhhoVKBZZMuJo7MhHIQ0oZKF8qAf7FmbJcH5ZafGkWDKIK4NS6FaHJ6ZVlmb
	 1KTKnGcNEkOpTG9SDqMoQ/dZshiRLyzZt8xHu6vvaCF22uMpyeogyW25nWM6R5ZbvnBSJ
	 vwLob3/PatWHchSiwlfjqpNJWFUjrGMrWJi+fjwrR1uksHeRErRebZDUk1SVBp3CL3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XGHBFV3u;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E474B606A31A;
	Sat, 31 Oct 2026 12:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E474B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XGHBFV3u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=XGHBFV3unaR+zfEWoql3mKNAHeMdgzq/ID5A/2fCdC24TJCir09F3qwtA21jA7AoTSvP3q3yc4xq4
	 iBk/EgDkkJUjasIK8sWuJZV6mI+q1EkFbDpsnefPoBcp3mj0UqDy53XQkBINhhEON29rvf8w+Yw2Ec
	 OJ9vGx1BscWNGQAQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26ae5e3a147f-b6ad3;
	Sat, 31 Oct 2026 20:48:43 +0800 (CST)
X-RM-TRANSID:2ee26ae5e3a147f-b6ad3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.33] (unknown[222.93.19.82])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76ae5e3a92f6-838b3;
	Sat, 31 Oct 2026 20:48:43 +0800 (CST)
X-RM-TRANSID:2ee76ae5e3a92f6-838b3
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: Avi Weiss <thnkslprpt@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Jason Xing" <kerneljasonxing@gmail.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "Mina Almasry" <almasrymina@google.com>, "Josef Bacik" <josef@toxicpanda.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>,
 "John Hurley" <john.hurley@netronome.com>,
 "Cong Wang" <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
 yana06070@163.com
Subject: Re: [PATCH net] net: skbuff: reject zero MPLS TTL before decrementing
Date: Sat, 31 Oct 2026 20:48:41 +0800
Message-ID: <179345092130.132560.5590780813492711780@cmss.chinamobile.com>
In-Reply-To: <20261031114135.3784868-2-thnkslprpt@gmail.com>
References: <20261031114135.3784868-2-thnkslprpt@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On 10/31/26 11:41, Avi Weiss wrote:
> skb_mpls_dec_ttl() decrements the u8 TTL before checking whether it
> expired. An incoming TTL of zero wraps to 255, causing the TC MPLS
> dec_ttl action to pass an expired packet instead of dropping it.
>
> Reject a zero TTL before the decrement while preserving the existing
> behavior for TTL one and valid TTL values.

Nice catch. I checked the wraparound against the C promotion and
conversion rules: with ttl being a u8, a zero TTL on the old path
decrements to 255 and the packet passes with a revived TTL. The new
check catches exactly that case, TTL one still returns -EINVAL, and
values of two and above are unchanged bit for bit.

The only in-tree caller I see is the TC dec_ttl action in
tcf_mpls_act(), which maps the error to TC_ACT_SHOT, so the rejected
packet is dropped. mpls_forward() already rejects TTL zero and one
(`dec.ttl <= 1`), so the two MPLS decrement paths now agree.

One minor observation, no change requested: `!ttl || !--ttl` is
equivalent to `ttl <= 1`, the form mpls_forward() uses. Stylistic
only; the patch is correct as posted.

Reviewed-by: Xia Yan <yanxia@cmss.chinamobile.com>


