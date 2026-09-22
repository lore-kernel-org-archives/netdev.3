Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505C22E7F39
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038104; cv=pass; b=kiPAP8eyQh8RUBVU3BkKEDszoNqSbmJmyvHaRx8bzWFGbY9mr56LXyI1nkDXu1ovkqGnJpoG2xrAfvM9qZGSzWjb5uRHtZUO9HaZ/a5WyHSTKRPUSMcFSqadzdlACAzznMYHC2hi0BXduIDfYTxvxA3CM+KZLXL/3b7eGR/8IhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038104; c=relaxed/simple;
	bh=BnrzXWHtRfdiJ3pqOPR5yk4FSFhY+j/DDmjhbz0Pj3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVh2swPHp6dWX3Rs6kjtSSyyXzoFlPRTe+1lWz9TSctX9vlFYXDHimcYzYuUPAl8oHUHWU5UPPsC3aGO6ZzX72obBVI/cHEDjEEZ4g4ZIPUBUee/tO6WSOYcHie3Q94nlOxIFZL2mxeEM7ztLK8KXRCkF/6/eM1BPq5tKHQUzVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J8ZSWqDN; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J8ZSWqDN"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd6so34803911cf.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790038102; cv=none;
        d=google.com; s=arc-20260327;
        b=ABd/0ngkdqAexgrH5XTLRNQDWQ8FWvcdKOVkeykAHA/m4bkIn8T7CorK0/upKxW4Xs
         R17pqZbF/mH9Hwm/9GszjEH3FQgtT07ZBAWvarcHB7PQJRqknsBDeanGc7wp3H3rjYyk
         jEhIAy3UYMCoCUa2PWH+0gVxK4zlRrwZCi68wQm4YBQMp5Rdwyr7WeeQJz5++XgOT3hH
         Kjh6jtHF7R7ejAucSke0tetmz7UUb+tXA5TIH5xo2F7wPqxciMA7lSOsyxo2RTqz2sEq
         JNNYK51fF/gZBVraWYo8DzCz4xs6rb9/EdsL5GGTah4ullm5Zb9TOJc8sptZAeGG057l
         zPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3LK+ozKSylFUUvnjcXsMMo9dDb+3ZVbSVsFuxLr9rAA=;
        fh=m/A3c6V7ljKQ8HYg01MtLBltb2ZuqLALfX0F6RUipdM=;
        b=nwSMU3SwUvjOVBiRjLgO5yeH72BShD2N4ybtsAybge4RkZrhwIz4L26fHNtXCx5TTC
         sQxa+7nY3T5xghy6H3yzGv3XvaCplLWpcemmLS/GkKHnJlEhrO01l01GX+JcYdRr+cp/
         cIGYqIsSNmvCyqeIin4EjxUofyNj9f2ujEunxCgJ1tW9jiJXZiz+NNoPwXdechgdG8ri
         3ciNmUMDOV08N9mRUKq56b3tpCJZ6h3Rs7B2rAGueG/I3zSMJUSNLkpmPv5pHYJ4k2E0
         fOGWOsrlr75pLlcMy/idQ1+2o+32Iv8TYUmAVngVArMqTju4+obpjmioJGwOAsQHqXdx
         yoUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790038102; x=1790642902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3LK+ozKSylFUUvnjcXsMMo9dDb+3ZVbSVsFuxLr9rAA=;
        b=J8ZSWqDNsFwhCuzOtu3NhHQ36LmhGohqELCoJJe7RvR/BuzAmgGAXX9RYZnMZsWO8e
         H9lU1aJKE2W7c68WPoMjZq3msxqZoMxdZwvE/xsv6BBRj5pteb6D8Fmf3WWI295pQ7cb
         EA9VBQAnBcqCBjXnHDz1Mt+4e2MW//jkHRhxsdyV5o++ADfDzmq+V28mNv3lQfQjQ/t/
         zdqU/oGB3RT9oz/JXCkLJoTChZKzqlI27qRlrauomWhkurzIwEVO/jJ05bRN7eCBZcBg
         mvCJMcj/3jF1orwmRABQDiytjxiD7iL+DmLz38gn9VWgpyOxL7msw9e4MBUpJmj76K51
         6IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790038102; x=1790642902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3LK+ozKSylFUUvnjcXsMMo9dDb+3ZVbSVsFuxLr9rAA=;
        b=eG84BSwdghyh7heo+8B0+1+ryckBZ32RD1mTtAbhxSTdyZuNnnYz+yI0PH41Tc0dIE
         R070RcTiwMVmXqsKAdCJ5h9KBY93f6ABGUmVU1dMTSDV1LM3mHMebbzmaZgRwJ0DWTTm
         H4iZV0NQ1cAiyWomzriNmZ7nkPozDZ5vT4trQKlN2kkeBEOUerXomLqJKz9DoheIF3xD
         wjLb5WqCDaR61ju3ZkbNjJxMcdk6hAjA3JNaFc70YcUgMFpljU8KVx4lW4VESmNXJczU
         aV7DmrzEXackGkPtT4Mqa60zDanQ77wrnhxBOtThybXrnS8X9P6/HDnNmfeOyAum+k40
         CNPg==
X-Forwarded-Encrypted: i=1; AKwUvBxLAhDIPhjeZ+droK4LFMtNuFxaM4o1CXQU8VBRJP/9Tk0ViCi8wNHyWHJjF71CSDfJTDyfAwI=@vger.kernel.org
X-Gm-Message-State: AFuF++nlZlLZQjaHZ1wtbLeUtRgKAbGT9DkLulMuMYfeMOA1azUHHFgb
	Ont4fK1lFRKN93yB6bDEJQIqZ/voVPVSh1beMBm7pQxyNj9C2mTYmFMWtg2C4noHx/hVBqasQf2
	IRQExuTHytp+akTu6Eb6Z6mkVvXyjmwTGyqrnpkKJ
X-Gm-Gg: AYBFou3lokptobzKJe9cKuDfIwb0kPcxT5QKO6i3SPRFQcVNL4zq72kIvRBKbcJOilY
	NMwtzu7/ku9OJDstQtVEDKhjohrTqK1wgPuzNtyDrUkI67fTby0garu7jUlkQmogLXzm1Yq1uln
	TwTt/9w/8dPVJz23RgjkpfFuVW1YHkN6ySY7Xvqg0zvE5tvY3Sa7bkwHf34bACycRPodixg9uAw
	yUMp4IrNMA8lyDZIabSoCF2p4mN+DlSxjRc9t26uvyzY9xLq5syKeukf3MDGAYMoQ6qUaxtMz4S
	AbKB4TnApfpmBWM9MZzG9q8BnKB7f3rcltIqn7WSVAVoemuZeMH2rylMjiOrkayvtolHzirvlnY
	AyP5qTJql8XVDzrqLdFa66OjkvEecPoRRURyuWUkK2vLDIFQWKkuwtOqF/78DjsSTV4ODd6FKfn
	EmvBIO
X-Received: by 2002:ac8:5cc7:0:b0:530:e8e6:bb67 with SMTP id
 d75a77b69052e-532d8e6e2acmr32479001cf.59.1790038101714; Mon, 21 Sep 2026
 17:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260916050144epcas5p3f7d6a44556baabd24027af8f4bce7893@epcas5p3.samsung.com>
 <20260916050255.1379192-1-irlanki.s@samsung.com> <20260921152604.2df7daaf@kernel.org>
In-Reply-To: <20260921152604.2df7daaf@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Sep 2026 02:48:10 +0200
X-Gm-Features: AcwNN1UYkBPuOvUGMNKq9NIUmTu6yNeNhs9fCtxsErhjcC2hyfYApg2nj1gadtI
Message-ID: <CANn89iJgAXaoepX1uvUbYhnutjvOPknPFheThf-gRWV-PbZZxw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] tcp: add TCP_ECN and TCP_ECN_OPTION socket options
To: Jakub Kicinski <kuba@kernel.org>
Cc: Irlanki Sandeep <irlanki.s@samsung.com>, ncardwell@google.com, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, lorenzo@google.com, maze@google.com, 
	sporeba@google.com, motomuman@google.com, srihari.k@samsung.com, 
	g.pokhra@samsung.com, r.kumawat@samsung.com, raj.kumars@samsung.com, 
	ts413.lee@samsung.com, ramyashree.s@samsung.com, daeil2.hwang@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:26=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 16 Sep 2026 10:32:55 +0530 Irlanki Sandeep wrote:
> > Currently, ECN and Accurate ECN (AccECN) configurations in the Linux
> > kernel are controlled globally via the net.ipv4.tcp_ecn and
> > net.ipv4.tcp_ecn_option sysctl variables. This global approach lacks th=
e
> > granularity required for modern multi-application runtimes.
> >
> > In diverse network environments (such as mobile operating systems like
> > Android), different applications route their traffic over distinct
> > physical and virtual interfaces (cellular, Wi-Fi, VPNs, etc.). In the
> > wild, certain legacy network paths or misconfigured middleboxes (such a=
s
> > routers, DPIs, or firewalls) are known to blackhole packets with ECN
> > negotiation flags in the SYN, or silently drop packets containing AccEC=
N
> > option headers during active sessions.
>
> My gut reaction is that we shouldn't be adding a setsockopt here.
> This is a routing property, really, IIUC you're adding the setsockopt
> because you want to use BPF, in which case isn't it better to add
> a kfunc for this? Why go thru all the sockopt plumbing?
>
> TCP maintainers, WDYT?

Speaking for myself, I also cannot see why we need to support so much
flexibility.

BTW:

I have on my plate a complete walk through of recent fields additions
in tcp_sock,
mostly from the AccECN support.

ecn_mode and ecn_options have nothing to do in tcp_sock_write_tx group
in any case.
This patch  would hurt performance.
