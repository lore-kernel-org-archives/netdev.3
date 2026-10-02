Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA7411F83
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926516; cv=pass; b=GRW/TDuyO98ojh5pLhUrfe0F6Q3RvsXUri6VPFc3te5GKXD/F1+LgsHYG5ZSTrM6djDNwOZRwIX5hc2Q3gSzWiPYChbe2gH/+7DUK/0KljEbHMwjCOtHG5Z4jUcu3RWFCr+ZfoiBksBSIkmvmzd/0lirdQPYHKwGXJrOaznfy3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926516; c=relaxed/simple;
	bh=SOA/vUAClX1o4iz9M+rLueQm3cnRTU1OGcw3mAwIki0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBe9XdTbEYCHarXpXjDu0qClGCnpcNlAQZwlGzk/jl18DUsQSEZwiTlAQHWJbMXCBjI/SUwTk2cbVVkON3uoFhypMhtWIUQDRAFBiLcgoBeHre9AjTNPPWCv7/WlRA41HyNRy64tos6g/iVM28y8dKoa1tHHHrSUVgn34pS9YG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLMWijyf; arc=pass smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLMWijyf"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b590a5b5eso4276436eec.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 00:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790926514; cv=none;
        d=google.com; s=arc-20260327;
        b=RgHSi42samIIwgMWxkmCbcX0DnrT2TH/RaNm9i/MkzGkUct27SMi8lsK87GnHLZVqu
         eHA6ffneRoDMIQNfHkUv0id2nTZaOJEaO5YM07EgcyV/ap3LUCLSvlK8fH/uwGCwnqSq
         IzTH/C5q20np74YEnkaTwx1TJOdqUjvXCBSsPvyEFNOky+Bmkf8lhQZXlRyJAe7zE8p6
         z91/5jehuJwTZvP8Ly+o6+EvamviQyAowv7F45vdLxxDqJ7azhUafQmYPX9XGjuwfHIN
         bMYaqlSqrN7rSrcllDgsRVuqDzj+1NX6BgXn6x2otjEbaWYKprZ8v35Lq1ekYlASinil
         GVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhYGQBrnZzLe8qsfJn+q2bKi7SfmwWl+6PXpp9jZ3GI=;
        fh=cxROooikq+Jlx0aTtSEpBlkWgxKsYFwty+lctuscqcg=;
        b=JHLKg9Qm0MWoHtS4F3U2SsDEmph2z0RrB0IBTUygbknK3qjqltO7XsPS8wNWH7idFg
         8XaQargRNwmwN0OGYuSDKFpRxOgyr51Dt5jTZMZgrDzDWnmics1WruoiU5ObhpXd5mO4
         iLhTgTPfGKPkW8nKCTTMf8XVeVXzrLjeE/w6LTncsbWGk8nvFhU7bSfToO3kDKP7ARj+
         yKAGZ9qOwxrowXAS0QUaFEmD9L3vOho7iQaS7+Lh+jcsU+/LrHZqP9WSOStJUoVaVHI6
         y1g6BdFPz6gpB8FrWxdZVPaMgnRpTZVj8ufZ6WxmISlo8bKMlzaYkVzVtWeWu/DaLs4e
         otzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790926514; x=1791531314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nhYGQBrnZzLe8qsfJn+q2bKi7SfmwWl+6PXpp9jZ3GI=;
        b=WLMWijyf3/qr6F6EzoafTw2i+h7E7Weq4q/XEsekiUsvio1txU13L4kq6e8saqbBEC
         njL5IbqK4mhZp44J3h8aI1eBrNNW4yeALzgcpx55195LmIcRnMfHUIErT5pFmNHMCwGl
         KozW85uKf5GrlwHwRBr85UBxQIub1m+cn7CuTOIW4rxktrLG66R1tcjssz3eWAVD8JXO
         Sp3m505TvlVZgyjpmspBFnvwQNKVNm4C/NAMJcyDJMn8UNtieGijjND3eSpbMNF6An2c
         4iqP2Z7PoDND+IrJpNOv6b0KsfMF9OQbiUBqyff7o4cAix0AErpUH1kdCOopo4shVloI
         ughQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790926514; x=1791531314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nhYGQBrnZzLe8qsfJn+q2bKi7SfmwWl+6PXpp9jZ3GI=;
        b=QnKC1bOJyJs0qGPg6gZs2zEc1SP+U3iiXPBsEahscxj/VXFOGDzRGXNrWiHcLws30Z
         Xne7muW52dKo+ElQ9SdROi7Yo6H13gdGvvkH1sAq/b84xceUZCt8kHdjkoGxN/mW25l4
         mreGtdv2oe9rNSxIDt0cn832hMyGbqcBP6CYKkd/a6ZIi+ahsMIvlSNXX9JGShJJTY1m
         V+ofvgHGRz1Xbzu4L+xKRSLkHQosJ/yj+Qan3r+obyuZ4rRZg4XbzFsjkN72Hq5/nM/c
         8cgKYFzSAdMaUpPOqEvack5ScxwsWu1vafYbDyzeyjbFyKELWfSQDiCznb2hqZpV9zip
         1wzA==
X-Forwarded-Encrypted: i=1; AKwUvBy3jikMPaYYCrQ4NXU5l0VFRrlnSWiP4+q2gukK2vpB/7/j5VdzrImd6bmp6k56OApVU+qLoQk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJY8/FECBWHH5kPmgH5P8oDYJpkTmfNgNzlv6ALYQy5TSus4ncE
	7nIb/+b2PpBgR+aCUa2KK2RXBTqilVh7Y+eGai9CsLbW9b9Pwrsz3tlkZ0nFSFpP1ssOz3muOrD
	wlFUwe1xo24YLzRi89lwlqBeqkFuxdqU=
X-Gm-Gg: AYBFou3eEt7RtMNpu4e8BqrJUCOzwsKvSi4sNbhO2wIh/M65R3EmSyALQX4UJ3aDM9J
	pwyRq77iehQo+iBFjxmB3Y++2LT+nphhc9HoaP0YCs3ii+YcxctcV5UASDY29SfIC1HQXtPVisk
	J8ve84oDkiI/HUYybA2wW/W0C3AKxZCpihXo+Tz95ZlF95rBjfZWiRzYeCw8uRRpib1TUwkKOwJ
	Fk4y2ePJXoIC2PRUXsoMffqyRyoPXyQf/D0oXlYf20SNXn+9nz47Zze1/eZYdfGwxcvI2AZFuq/
	T8/DWKSggtJJkRaArQix7nvrKCUdYBTzoupRY/Rxma+7Muf1toX1i2djHJYTj6zDHAoA
X-Received: by 2002:a05:7301:618e:20b0:34d:861c:99b8 with SMTP id
 5a478bee46e88-34f150db8ffmr2092936eec.21.1790926513945; Fri, 02 Oct 2026
 00:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790917676.git.zcliangcn@gmail.com> <179092437135.1402591.17012333474783660749@kernel.org>
In-Reply-To: <179092437135.1402591.17012333474783660749@kernel.org>
From: Zhengchuan Liang <zcliangcn@gmail.com>
Date: Fri, 2 Oct 2026 00:35:02 -0700
X-Gm-Features: AclHuK_NpBMd08Qkv6qa8LjOg0_Bl2th9r6S-C4LVEqwsBQsirKBOThonGult6Y
Message-ID: <CAOny8pvoKn2c9yHNuek_D58td5Uq+K9NLfguT43rYYwE74fCpA@mail.gmail.com>
Subject: Re: [PATCH net 0/1] net: netdev name hash leaks kernel text base
To: netdev-bot+sinfo@kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 11:59=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>

The issue was discovered using an LLM.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
