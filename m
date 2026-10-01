Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB303B27EC
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 05:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790831412; cv=pass; b=MH1y+0zyZaipDE4nUXFEOB4RyTMrm++4KkLvg8NLs5Oze4HMzql5Rfy+VWWkc0or2k22wd5SSyZBcVQO683vA+UUubgCSLTljuVvHCSttdhyCtnZW290dFWCWk0Cg+Vw1ClV3dC/0JSjORU4rzWgNcdgwqYz58NYea479LLHeMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790831412; c=relaxed/simple;
	bh=GQ0IaYdBu/fv58w6uxEVGfeymlDbMHy4x3hTv+yEzgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRvrxULJAN9W8WocbzDra7FtgV/vycqPIkTOXZDPpEJ+AeuoMo/XCsjb2pr8t0d94tf8ozaZWKW4flGzZrUDGdW9DfvJYtDDu4gdXIFCHfoC3mg9wrv/N0shBY1ctdYlKbGqH92SQOunCwX9x5kiHJLtm5k04aZNjWDIaH2VAXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HC9w5aC1; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HC9w5aC1"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144ecebb6cbso2212851c88.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790831410; cv=none;
        d=google.com; s=arc-20260327;
        b=ASn1U8RQH38cO5nU0/T/KLAbmn2n2YpQxS1qR9u4sCrVw4P2fgRxD5urtZbb1GGZO4
         TOQgbAAX79DjBgskkVIwAwN2BYVcq8GCG+HxARuT0zCni5HqhHA1SOHf8x8+uMh1kf2y
         L4tWUi1mlr3mYe5j4W5nfOXl7SdVxtSAp8yTA3Dud5Z6G/Dyy8bOAaDhyc3HgrBcJrpl
         jjag1l3nph8qK17Iw3inbPT4D+GPfzZMnEopi4iolEnSmio0TzIkgvdQAMl7hQvW41jx
         aw7iC2FDN5AYwhVcrkUXpkeO729tX8z3mBWXESXtI5a3lVPFrxvJZqgww0jzTbxMyAYq
         N9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GQ0IaYdBu/fv58w6uxEVGfeymlDbMHy4x3hTv+yEzgk=;
        fh=snhT099XBspbmZHk2jpqQPShq2INAoKyB8un59QP7NU=;
        b=jF2kOSh6T0zvj6d6YgnlKvK1HF7foNyEbRasC7DnxpOQokNKMFAOCU2kcAu1j9LvjE
         21H8tV9ab2n33nSORMy2n8anLaykn1OxVosauvAu076I+37M8LB6EeFq0V2U1pbJP3J6
         Y9xvowbhNAXbH/IjRKJWGUCt6pkA/UmnQKivgLmv/fA7du8BB/m2A7ras0wCYp5lNW8h
         j5E7h9jkhAuplgGIcl6H7zZmQQxvU7JEyxZK7ZpvnTcYPwI2BjjBHJfKXmFMKwO+ulRJ
         V3cSiVI/xuJSqwVPLauz3KdJFnOntHvqSfDXejDmj8M3PfoOowuQfhVZEzrV3StLTOzO
         GSCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790831410; x=1791436210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GQ0IaYdBu/fv58w6uxEVGfeymlDbMHy4x3hTv+yEzgk=;
        b=HC9w5aC1Y5vLNusHm443441banDLkLplzuXm9Z/eVMWsNgNDhBRsClL2QGQB07/5AX
         Cwu+PkL0EJoofa3oecXDBy6R6rctReyxGSQkyue9r6fej2WjpxmbS3XJp9P3Z8RhzaIg
         I4lWmAuujeieFi+LkB3L3xjMivemAmXlmSGvW3ao/8atOjWRvTqVF/0iRZI7oVjxHZ71
         NM6QEEgTEwe3EhGhAsceKFNE5oitH7kbMWDx1MAxlskw0U9AWje5u19qTnZODMigFFN6
         G280Jb5hDtpAE75GNrqWC9puGqbnwl5mOiPQhy6VDW/BsX2HLKq12Y04sh4V9OSr3Lo4
         XSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790831410; x=1791436210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GQ0IaYdBu/fv58w6uxEVGfeymlDbMHy4x3hTv+yEzgk=;
        b=kyKiyPTFgMcqyRgw4osKLRWn00zM1OL27P8faihW8IicaAVhBQmMXreX3+yQm3fvZu
         kOuSTnTUSvf4pn0QYwSLPW4lAF8J6DgAstno8vb+UQHa/TtV1SscsLiA7nUHstfi4vIW
         a/dtr+evAF8XNtxdesS29rY5tStQq0VMqTbTHEDtRggy6JE2b0aR4e+i8KpIKh8ULhA2
         nuZu30C06NKjbNK4E/0E23Kr3c+kB6ShWz/yzVZn3ZuM6Ge3bb9jj+dkmRL00EVhjDaF
         3sjnSVvOtbr70MJc9pVkvlTRg5QsaDW4w5rYpJlyAGF5CfDkAhXVNpTcPAibx/uRpMS5
         QO8g==
X-Forwarded-Encrypted: i=1; AKwUvBw1XUIlnfI98A8A3RbzkjEZOKXwAJXady7g/bx7QrNh3olHgfH6AX/EbAIAurpWgA5q9ISqH80=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6dvyOfnNHq5ftM0q3K9fgHKCZJK8+LYWzVX9eYQk/N2R8gz5y
	ad4luSNVSO2TvPrXHY68E8pKqhRoDw3MoTYQ9zQbEFFkdqWHwflVqzkvgeEBuZZujOvUoYzvG7S
	QbyzTo/IjZ3OOe7YOLiaTYi0jfu85GkTdvh7F6H+m
X-Gm-Gg: AYBFou1FuCYWDF5LuNPwKQs2N/4+I3U1CSalyX/Sfz2NnZwKYwomMzSLz7E8KxOcnYX
	SaXAEf3B9HZY2DxmdR0cUjINTLrVvJ6rpHBzf9DXaS+jGaNPdniPcxTQBfmvSz6lc9kHgcCUS7P
	Pjz7rPQXLb37J5W9sYSi4pZHfPwKfWe9RS8XjMloDGbMZAOtGuhuQ9kZtEGuCn470WrfC3VpWYL
	ERiVkCDOQHPa68+4XikFd0AzJsHl4619eifsh9MrHyVF0A571dGE/c7BCbYaoDY0+B0tOamFJm5
	tPInxD7AZtKmijbsfOl7+ChyDbJ9lP+YOQKSqa5OvQ/bSHwS1HnVUefXa4nSNc4aS5UnqzS5fQW
	a75wyiJpZhewPAN0tRNQDCR65wFU3EnMLxI4acu7tPkSl/KiJ8Ozw/1iC1DrE7lJLB2g=
X-Received: by 2002:a05:701b:2712:b0:149:f2b3:efb5 with SMTP id
 a92af1059eb24-14d33399c59mr3561098c88.33.1790831408757; Wed, 30 Sep 2026
 22:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929153834.566551-1-edumazet@kernel.org>
In-Reply-To: <20260929153834.566551-1-edumazet@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 22:09:57 -0700
X-Gm-Features: AclHuK_AfPk2h4uznCF6Sk2HUcxZ45JuAagrDX8B4QT56NnbZfdttz5m_v2YSIk
Message-ID: <CAAVpQUACWtzZcCmD1D_QZ+fgmwN5rcm1KFTAY59QG7131kjyaA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv4: use zero IPID for atomic datagrams on
 connected sockets
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 8:38=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> ip_select_ident_segs() uses the per-socket private generator
> for connected sockets, even for packets with IP_DF set.
>
> This was historically done to work around buggy Windows95/2000
> VJ header compression implementations, dropping every other
> packet in a TCP stream when the IP ID field did not change.
>
> RFC 6864 section 4.2 states that "Originating sources MAY set the
> IPv4 ID field of atomic datagrams to any value".
>
> Packets with IP_DF set and skb->ignore_df cleared can not be
> fragmented, neither locally (ip_fragment() refuses to do so)
> nor by routers on the path.
>
> Set their IPID to zero, like we already do for unconnected sockets
> and in ip_build_and_send_pkt(). FreeBSD also does the same by
> default (net.inet.ip.rfc6864 =3D 1).
>
> Connected sockets still use their private generator for packets
> without IP_DF, or with skb->ignore_df set.
>
> This avoids an atomic operation on a shared cache line for
> connected UDP sockets using IP_PMTUDISC_DO/IP_PMTUDISC_PROBE,
> and TCP no longer touches inet->inet_id in the fast path.
>
> Minor side effects: IP IDs can no longer be used to distinguish
> network duplicates from TCP retransmits, or to correlate packet
> captures taken at different points. OS fingerprints will also change.
>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
