Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697475;
	b=b1orZ5pQ9ucd7XeQLrFTJ9uShyFcse2PoiA29BsNUV/cl5ZpL9Wv2gMYPziFSIt4Lt/n
	 VJipKd9x3wz4J0ayb+DxjeqZP/Sz+bnyTAXR7ct3YfJ1oltC4N6jPCCCy5aandUZZSyGE
	 F8Db+oX4SMh+rPbeB+jC6JebN18KuVXOdcpoRjKHWiGVv4sJS+9kis3WlD2+iSYfj2xsF
	 tGxdZ15bFmFyK5PSrKOICk0uDJGXrZ6CcSJ0qx9BAHrOGj2rXoxgA4ly3GDnOwEgoP37V
	 /NoneuRvqQwTGe1W2PSJGbp1dva+GLomgQhSFzPGfujz2O3bZQvjTOTcYz2fB1KXdoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697475;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QEnTzfV1jdyg9K2Ud+Roduw9tIJzB4+udWsZS8miQsI=;
	b=YPAbsmVDlhbV1HhIrAPRDvYqkKqfDi+BFLSzV//Yc7hwspZM5l7NpSR2u5TXBIacYcRg
	 bwgZNOMjUb25/wdU1cYnWMXFpDZiT00zYTnUjcsdt6bnjpMmEKNVWoUOZ7mJnNSHQzr6i
	 h+x45WHrG+439CWH7CGO9l50W0OHV98WG6F7q/ELFJ8X6hkLzw1xn82VFRwM2NNF6+i+2
	 NAg2c7Uf/yiU0samw7UzJL/mzMSu2AeG1xMV94UkKcAPW6GHLdaGxmtg86H1cnmWNMBMz
	 T8LaQWTvcX+X4QHMPIN6EhAetTZNHdZBCvpy1LGkQ0Qp05J8d6kjFkCAUVa7D0IdC5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hdvf/mJ5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D2606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hdvf/mJ5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463691F00A1A
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697474;
	bh=QEnTzfV1jdyg9K2Ud+Roduw9tIJzB4+udWsZS8miQsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Hdvf/mJ5ZHGOzSCKYdsRvvgpxP9NyuiGPjXDwC9F4c4qE/LvKIFjwUjtJDJLJm7Py
	 aRvpk2ugz57hxwTosiaimMNfeuNPRq9JNweqm3jt9O3wUnxIrRreVaI6jBrcrAuk39
	 9jrK5fnOXiP/opcO3XCxKr0lvXEIT7NlI1Kb/Ch13Z/u89g2qVl9ajqZVD7U3Fig44
	 sO2GrHdNzej2siy3rxSoSp0ExVF0i63f4EXC/pkY9dMXVaIXH0+hNfPalb0N5UDbV+
	 cm65XOcJ8PG6kTIOHLyGrD5KyuZQsjMO2zClqFc2H3rsY9EiBGCUk5MmOShys6UrM6
	 v50uySCIeMmmg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4a85c656c58so2384159fac.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 01:17:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxoFun64Gq0NPkeHJd+D+CbY5btWQ8B6TRtiOqJcwkkvQMl8S52/o6b8W/DVL01u+l/AkExpR8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WnD6kA9SJV0MANG4fO07p4PpR2Qj3pkNIl+BER1GCYbnLEIwH
	kGPr3ue/E6LP0gpwzIxVUDV0cxUmUlBFsy3mjKaklv5vHFnRHKxMefUtSTkkIqJjhjxQRndcC50
	i38L6Oq099gZEGOunjoIR7pNbccatINQ=
X-Received: by 2002:a05:6870:ac96:b0:4a2:62e9:9172 with SMTP id
 586e51a60fabf-4a9077a2890mr7111761fac.53.1793697473532; Tue, 03 Nov 2026
 01:17:53 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103090011.4128420-1-edumazet@kernel.org> <179369696044.488859.13046087773855353137@kernel.org>
In-Reply-To: <179369696044.488859.13046087773855353137@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 10:17:42 +0100
X-Gmail-Original-Message-ID: <CAL4Wiip19CB3Hbw+=vzaJN-iV_-+nDbSe7PtVZ6JHW5x7NMzcQ@mail.gmail.com>
X-Gm-Features: AclHuK_TnOcBCakYEuAq1nk-7Df_LWG5HglF9lHlYqv321nyKfeKgYPT3IfxkEY
Message-ID: <CAL4Wiip19CB3Hbw+=vzaJN-iV_-+nDbSe7PtVZ6JHW5x7NMzcQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ipv6: free ireq->ipv6_opt after an RCU grace period
To: netdev-bot+sinfo@kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 3 nov. 2026 =C3=A0 10:09, <netdev-bot+sinfo@kernel.org> a =C3=A9cri=
t :
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>

I think Sashiko is an LLM.

I do not think it has triggered the bug, but it seems plausible to me.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
