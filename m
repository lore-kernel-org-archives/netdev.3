Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEA42F90E0
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 03:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786245697; cv=pass; b=Zc17/QuUdRysvEfNOCsNsls2y4fvKl5mq5cNSTSx1mvf8mlEXSHJN3fLheQnwroUnC2QLSE2colTbYCcNN5pMw2lQpxytaETVN2yQrAA7V9CAvI8BJ6tTlmsN49VK/2JAF7q3bMf4Ge8QOBtXXDQ8h/8BIDGnqIakxPIxzP/y3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786245697; c=relaxed/simple;
	bh=SXY4u+9DaHUNjX6GPRBNLuUHc3mmM56iddu3WgKxZ5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUCGt6WJj9XoIJHAlnMAZoJZzDyDXKbf9/uGvRzl1yxBspZWB4YtPbBX1aWAKyeiLBGd64k1SOXNTwEChu2OhPgfktJ5CVkc8tGKrJ0/X4HP+1WSomc8ZhEUJXKyf075/1BBXtcpJhzu1UinmGwdNQDUM3tEMOK1Yv1bvyCVbd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjEALtOp; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjEALtOp"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso660983a91.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 20:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786245695; cv=none;
        d=google.com; s=arc-20260327;
        b=iQDefCRiYD0wt1AVLZzQvOzYzbMjTk++DMpn9gAzZOjl1aUfruzYcxFPXUCYh4hjsZ
         coZb36WY2DAZIAazrjo5gtpvS3bLrapziB9JqgjDJvHs06pWsIzvguEoYGtgMWwcz7p8
         SInpOLxjOf1YMhUax3JmXGFwukkazjeuBb4X4STUBGfv/hQUGCS6TXsPDpgaCuTDdi/x
         vVHuBvlxS3Vc6SG5Hjyon0EE3K9O3e+5dhRE8zaQFHAqzQ5PXJLT74Qg+MKTHmGXdl22
         +K7Xt3AovozmpWJ0wYdQbk8SVnZ+/G5JfzLoxBWfPe53qtLQ5mo5E6U9sX+w2HUJc1So
         JHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zNAXqNIRs3CIyk/KOlrIpIzPwG17uGFnKvl7uh5nBcw=;
        fh=HclGXQF7QOOYYav4/Ltsj/g2uOBgX/rnSaSY/sKPqDA=;
        b=ZpfNv+4D6qA92iUuUEOsJQ/22yrE92uT8ZXzlPt7/iJcovuXNdnFYj7vYwOKD2jAHd
         l4nNxTgmZYb/w5wdOhN2z2ec8+vCDmsVUKdncToZwuEdmwtv9eqsj1kMGxshExckmqGg
         FpxKzAx+MBRVfUfP3XgZXrF41/t9hfHKw432moGeD1ErO5CCEN1A/7nWw0Rk8pXqO78h
         rXshBLPFLp7VujeNaY/4qpNNP97NZnXBEm9HyyenyRznZJQT+G5WgQKSrCgtcrf+11+i
         zHPhyHJUlCRv8IacpZ9LoX39cvW/ilDkDODFGOZG+FPnfyr2bkVYBDEcJUDrc/aN3ed7
         IALg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786245695; x=1786850495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zNAXqNIRs3CIyk/KOlrIpIzPwG17uGFnKvl7uh5nBcw=;
        b=pjEALtOppMnLT4oy+28yB/k7fFSuzI6qnEF/KmoHFEn/6FK+Xrnyc3GKFVrwfmWfY7
         rbPZCnkVgx7/ezGD5+QAt+BDDUdk+Qj833b2ikc2bX8ctB6dobMiBSbFRLNqraIAqiDo
         fJWamcDs09eGryDqt4NBZNOf6DJ9lZ87979zryTv/WYloL5g25jwQT/UGHPlidcbw8OY
         H7ai/9smbV+Y3Hm0bHGYMavpX4LKwIOEBZb3v6ZolMsv3YLqqO4nBXphFG+PfSyc3vaC
         qYgWnjvGR1oghhAyZMhoE/0sXiAJjaH4OZczKfwxmvt3aJRAaKJ/8AsZmltcxzJndZmX
         /paA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786245695; x=1786850495;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNAXqNIRs3CIyk/KOlrIpIzPwG17uGFnKvl7uh5nBcw=;
        b=OmkKuR3EK1ZwnVadws+wmn7L3KP7ZZj+Fo5sIOpogqxdDpuPNHXTH1P+b7PX9Kp06d
         edX/CwHl4cQPyAIBxq7tTVh2nnpu9Pd4KdHxKMLOSlet/wdPz/bEtibL4UEhS1GmZDvq
         akucMen0STeUy+0+8jZGdwyOWdD46dK9TJEiT2WsyjoOji57g59SIRCT985ONW/Dc2tv
         w2hnG0KsDOFe5jMAlleO72R5PT8JFsJ5TXtmTeM3TOXW78YVaMW5O1UbF8LO52NGkgmI
         OBc2xxQMgwnUQ9Nc3vwFrrQWvbcFtKDTzcOGyfgoR/uq6tKSmfqQDAcT5GdTSZAL0904
         agqg==
X-Forwarded-Encrypted: i=1; AHgh+RrPYlPDxFa0cgIOLbz9ld7W8nUcGci6Ghh9nIRJXD5nECS6wuDiyzgX++NpTinxv7trqPdrQxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd1WIJmsOajfpWolKwYQxZh5FXzqPm1cao/HGb6MsUl1I9jIuO
	wl4DFwhVKWfRHsI4G1pgEfRmFpHifmBImUt5RHh6TgOv5emw0AlGswRDu5CjeZkBFYty4EhlAIC
	wD1fT2c8W1Qumg2A/BDGklUzoc6ImCCz3X0Mr9hSD
X-Gm-Gg: AR+sD1173aW5oS9Ak0q9i9FUqomoz4Rv4/lXK+cxquzSJ6aOTl5Ur0MD7LtzNMXrG7R
	vK1cwAodzW+95X0cioGqrzTiQsFzeU8cQJDe6tDsSLPXuWddysRNQY1Z1MgEVtMzFxTcq5Q6P25
	8Y4ju7gZLuO7zjK747Qz9asDb8Q5HE0M2ynWFCbTlYbeJNW8nhHT5pZf9mX8u1oD4tqx5MGQ+3r
	BWxy5koxykeyiEEETcCFgKwlmIjQp3cfy2c3IYYh8n8Et0ET8jjUCQGjSQBdsqMd+NFBZOACVwB
	lFAUuZJu5uTN26gClg/MF1c/2LOPckv2UfIasYo40uztS0j4M5+TxW6O/UgzHqdtwnG8o05ADSJ
	UbwIF706iWbVG8GwQ4TQCCjdVmZmgCusM7gRc6ydnRi1mf12fsPRqUnfNVyaD3ImZU5MwwcFoZs
	lY1FrmGBmrQqEqog==
X-Received: by 2002:a17:90b:53c5:b0:381:bc4c:da5b with SMTP id
 98e67ed59e1d1-3903c61098cmr36787938a91.18.1786245694545; Sat, 08 Aug 2026
 20:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
 <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
 <A7A3F2FE-B18C-4F6D-A5E4-78164D6904F5@amazon.com> <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
 <9E49374E-D1D6-4D41-BFE0-03EE734DF9F2@amazon.com> <CAAVpQUBtKBzq36Wz9p3MaHR=G10-NFBtQXgGW3S3QV5THW2iCg@mail.gmail.com>
 <0A7EC161-4EE6-42D4-A10B-7B4C609C7B32@amazon.com>
In-Reply-To: <0A7EC161-4EE6-42D4-A10B-7B4C609C7B32@amazon.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 8 Aug 2026 20:21:23 -0700
X-Gm-Features: AUfX_myrEsRggJvNv33aIb9loVFZpgzUQX_MJjCGYRy9lkB6LKuULUQRXKGim50
Message-ID: <CAAVpQUAEV2XVxkEGBEoB5ocEjDS17cV4wjsVud_AHBYuUNj-SQ@mail.gmail.com>
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when
 closing sockets with pending send data
To: "Ahmed, Aaron" <aarnahmd@amazon.com>
Cc: "edumazet@google.com" <edumazet@google.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	aws-binance-tam <aws-binance-tam@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 8:42=E2=80=AFPM Ahmed, Aaron <aarnahmd@amazon.com> w=
rote:
>
> Hi,
>
> Following up since it's been a while. I've tested on 6.18.39 (latest
> 6.18.y LTS) and the issue is still present.
>
> Baseline (55,542 connections, one client SIGSTOP'd):
>   TCP: inuse 55542 orphan 0 tw 1 alloc 55543 mem 8236
>   Mem: 94504 total, 693 used
>
> After ~1 minute:
>   TCP: inuse 47394 orphan 1 tw 2 alloc 47395 mem 1404546
>   Mem: 94504 total, 9023 used
>
> Updated repo with new results and .config:
>   https://github.com/aahmed71/tcp-linger-memleak-reproducer

I ran the repro, but I didn't see the behaviour described in the
README.md; unbound growth of "mem" on the server side after
client SIGSTOP.

Before SIGSTOP, each socket on the server side has quite small
send buffer, and it grows after SIGSTOP on the client side.

A few minutes later, # of sockets decreased, and "mem" was
263705 (~=3D 1GiB) and the total send buffer was 700 MiB.
Given 1.5k MTU and skb overhead (552 bytes), it roughly matches
the "mem" value.

Also, after killing the server process, the value went down to
almost zero, and I didn't see the leak.



server side (before SIGSTOP on the client side):

---8<---
# cat /proc/sys/net/ipv4/tcp_mem ; echo; cat /proc/net/sockstat; echo; free=
 -h;

191220  254961  382440

sockets: used 45715
TCP: inuse 45577 orphan 0 tw 0 alloc 45579 mem 231374
...
               total        used        free  shared  buff/cache   availabl=
e
Mem:            15Gi   2.3Gi        13Gi   332Ki       159Mi        13Gi
Swap:             0B          0B          0B
---8<---

---8<---
ESTAB    0      1912     192.168.0.1:6666  192.168.0.2:24543
ESTAB    0      3100     192.168.0.1:6666  192.168.0.2:10770
ESTAB    0      9640     192.168.0.1:6666  192.168.0.2:47995
ESTAB    0      2160     192.168.0.1:6666  192.168.0.2:27574
---8<---


server side (after SIGSTOP on the client side):

---8<---
191220  254961  382440

sockets: used 753
TCP: inuse 606 orphan 0 tw 0 alloc 608 mem 263705
...
               total        used        free  shared  buff/cache   availabl=
e
Mem:            15Gi   4.4Gi        11Gi   332Ki       156Mi        11Gi
Swap:             0B          0B          0B
---8<---

---8<---
ESTAB  0      217341   192.168.0.1:6666  192.168.0.2:25684
ESTAB  0      120004   192.168.0.1:6666  192.168.0.2:23340
ESTAB  0      128672   192.168.0.1:6666  192.168.0.2:48728
ESTAB  0      141194   192.168.0.1:6666  192.168.0.2:41513
ESTAB  0      121421   192.168.0.1:6666  192.168.0.2:33507
---8<---

---8<---
# ss -tn | awk 'NR>1 { count++; sum +=3D $3 } END { printf "Sockets: %d
| Send-Q Total: %.2f MiB (%d bytes)\n", count, sum/1024/1024, sum }'
Sockets: 601 | Send-Q Total: 722.04 MiB (757118970 bytes)
---8<---

---8<---
$ pahole -C sk_buff
...
 /* size: 232, cachelines: 4, members: 28 */
...
$ pahole -C skb_shared_info
...
 /* size: 320, cachelines: 5, members: 13 */
---8<---
