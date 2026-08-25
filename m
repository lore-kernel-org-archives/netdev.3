Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960592F746D
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787622641; cv=pass; b=Y6TOTsebSwnhZpIUt/opmbNO1wDRIzUBEUxdmeMeRzmXShRtnFuePDqncKxkitbLcGQcWAW7NxZra8Xr5ng+OXaOqdV2SthKR7RyOvDGD2S/v8FqQf8TYtGowJYOGOUzTF56ow5zWyuEPl+Ce7HqiP8e1p1+Cw3IH/iwGuGSzpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787622641; c=relaxed/simple;
	bh=ciEOebO9usFeN1jndYGcI5ipjRfv5JDoC4wVn6B2fSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6hSTMX3kSueZKqNtq1BTqdVkFwo+lRuaSajAwdLwTXlF+M+JOCZ2B+2tyapoB5SMOt8qDF4E6RIr8szWAhnXoFSBdE/kpsn6b1lXJqsCVV+FRsKwORS98tWdDYZDKop7yMmIRtFG+edQe9ypotyeXxTfcQ14iF5+MDVrZgxPe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpcm7yXY; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpcm7yXY"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c149c5722so2297351cf.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 18:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787622638; cv=none;
        d=google.com; s=arc-20260327;
        b=KkrJ4P9atDDmvVCc3OsUDULx8lVuhS9pnKOrxKKzF2b7iyX7JJHdVN6IEk2bSTHg9S
         8fruH6Wfq4oLRSylPYbFuRSQV1Sg4/NnCeQ6V3yubuWfEMJ/Flx+2YW5iEUkh8FTKQjz
         j6+0mXoL/xmiN0WcxNGz+55nG1ANuGnZL1xjJlbgm98/fJMCYjUeOAGEvUJfpUL5R+B0
         BvdRzRag5IUxVZaS2U2sA1uphcHc/7/FdEpmt7J9SXH20RdBiozfxm4FwppjMB56uFiU
         7lN9xpCbgTXUB+k1QVPDFOoVzjmJ31vcNyoZwyXhKvdIOy/DGnR/tiKrpmnRlTCXOL0L
         9OXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ot9cZETZ+9/Bl94L9bOTpG2Vp4bOKUeZwFxEm+rMm4s=;
        fh=/YcMW4L65pOkCFDuNjjhQZQwTh4sAFRTT33afBOKJ1s=;
        b=VPzNn79tsF2ZfBupYlpRKgA9qWjK9jeQsYPKzHyyluCFVlE6OSegswVD7FKumWEYOg
         dseFgmXf0+2BdZZqAmvKGwf/BShnowPxG9S0mYubTcNI1L8vjpLxLK0qnJQawdgSWNw6
         HdySGmO0X8+8IShIHczBApRDpB8o/qL9MoQ11iziP0R/DJpMJtLQBYrElrq8uzvXxNGG
         ON5YIgrB4aka57Sn7ruSWiMF98GCTWgM4/tNkZYuHEVs/f9ZsLxl3TYvPuXkEmNlrWrl
         OewfIUPZRSF0+LzbxmfUWM1ANJa/BWlg5suAncepc5bSDmUM+LLPiSdzZauad9xS/+Yh
         XyzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787622638; x=1788227438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ot9cZETZ+9/Bl94L9bOTpG2Vp4bOKUeZwFxEm+rMm4s=;
        b=dpcm7yXYLFPBLiIvvecralQ0s8sNT48RVHUxrDrKDx4fSFhgVIIlUEoD0wB51sA5qQ
         yTb+AECnd9y6P/Iu0Hm+jWG6ltrEEKqQz98zKy9CQwS7SY5AmyxgoGl245Ci+iZqKk4W
         s1bd74qIweT+Rb4nEt5/xZqA+KzL+B58RKdMlhJ8Q9l6QvYazeXcOwZXavU3fOjIugP/
         NRuddiZp/PUDJHwbOlIUBV5rw167IhRp4z9l9fu5RfPd5wox695pGgulXe2yxQYL/pl1
         RPvVSvZhth/tfCVeuyDdLwpjKb6+2lP0HH2mewfOd+shBjaXJ9oSZ9EczwHyY/M/KCSC
         jxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787622638; x=1788227438;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ot9cZETZ+9/Bl94L9bOTpG2Vp4bOKUeZwFxEm+rMm4s=;
        b=ZlVwm54ve8T4OdUAQUfmnMH9bstfn5TCHhPEq7gdQpzcp/X3o7oAyFdaIsy/oODYBP
         PT0kEtR/mQ5ApzmonIiCbajUPntYCGO5uY2M6EqzxYpD5Exr6E9/pwB8eUKRKNV0Rix0
         ajon0XIv9tV3FI1zmOHJ/yVnZiLLBG4NuNA1rpVirMRBql68uPiF6q4URREkp1sQhwFY
         WyeJ4U91TJs+4rx3DV8Sk7P5pNIdsARjoKz8m2xwr393CXSb14+EIuIdyKVVbcCUpP9C
         JnxOx84U3Bf0kCl0zSRxIXH7sup719eKzckq2E2HBwdViePk6g35fr4eEhDFVg7t+fuE
         QZag==
X-Forwarded-Encrypted: i=1; AHgh+RpA90XhkoM5gfm7ahxmUUbPriz0au9DQATpYmShcfbD2zt52CvKyyhQN7pWFwY6y3OJarUAXkI=@vger.kernel.org
X-Gm-Message-State: AFuF++nFekVrlV4u81ZPTrjHY+twFPsIVBXFXeq2FAXhXCynijizUHiG
	77EHyrUNf8zEw4sCbxbhjUyF5+MP2OHe/AzNwFg2QcZmhmuPELheZEvpTtOAf0GsjucLpomYCtz
	7Amdjt7Jxp1qO+OSFuDJLPAh84QSGgp0IPFTBlZ/i
X-Gm-Gg: AR+sD12MoZALxT6VnMYUsvZP6/l9pLHF6psegu3U5bDmDTJNmTX+U5c8pd8T1fd0QFa
	dzN/x4/POEwYD3usWiJyYQPc6++EKhM/hhyqDusy2G6cRZYIP9RZaIaKDwI1bJf99nM1X4U2Sss
	DCrCouJgrMTNEJRgrnNB1yl986e8JEIe5u2prK6LBgB8g6X2b3RqBUu395l+MxPQeXMDx1e//Vt
	GI2DQQWdDtXd5GzTwPwAHb3kGvFVT8L+h/C+OCoKe6dZSAvjX81skZaP9rxV210QzKxv0MQ4Obf
	FWWspVhEz4fbQMyv37DwpSZg6Hqu2xIBclGhzC7yy6NAPsoZigWVOJCOEpQx1U6l6A7MtLWGH8q
	wdRkFVtXfwX/I0CIM6FsH4XrrGdmx8BX14xraBFUIXiOz+XI5ZB9Na2EV
X-Received: by 2002:a05:622a:2446:b0:51b:ef78:4062 with SMTP id
 d75a77b69052e-52e2ec997a8mr43708131cf.10.1787622637783; Mon, 24 Aug 2026
 18:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825002924.1439-1-hdanton@sina.com> <6a8ce8d5.dbb3a75c.7844.0018.GAE@google.com>
 <CANn89i+wnTLC==UnXCpjsS4YxvEfhe5oK0N7fttbqr1zKyqdug@mail.gmail.com>
In-Reply-To: <CANn89i+wnTLC==UnXCpjsS4YxvEfhe5oK0N7fttbqr1zKyqdug@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 03:50:26 +0200
X-Gm-Features: AcwNN1XCfbByz4pMJzFYqBmv4sXNr2uQ7bjS0dHlC04llrDhK7Yc292mFqw2WxU
Message-ID: <CANn89iJ01nSttn66xfaM+AOa4U-nvw=pSeqKxzvU64426-ZJrw@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
To: syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Keith Busch <kbusch@kernel.org>
Cc: boqun@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Aug 25, 2026 at 2:59=E2=80=AFAM syzbot
> <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer is still trigge=
ring an issue:
> > WARNING in tcp_tsq_handler
> >
> > ------------[ cut here ]------------
> > !lockdep_sock_is_held(sk) && debug_locks
> > WARNING: ./include/net/sock.h:1799 at sock_owned_by_me include/net/sock=
.h:1799 [inline], CPU#1: kworker/1:0/24
> > WARNING: ./include/net/sock.h:1799 at sock_owned_by_user include/net/so=
ck.h:1812 [inline], CPU#1: kworker/1:0/24
> > WARNING: ./include/net/sock.h:1799 at tcp_tsq_handler+0x1a6/0x200 net/i=
pv4/tcp_output.c:1292, CPU#1: kworker/1:0/24
>
> Note this is a different warning.
>
> This one might have been added in nvme-tcp in commit
>
> commit 19bdb70c77d3b24239a453291299b64040bdba86
> Author: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Date:   Thu Jun 4 11:32:08 2026 +0900
>
>     nvme-tcp: lockdep: use dynamic lockdep keys per socket instance
>
> The authors assumed that __fput_sync(queue->sock->file) in
> nvme_tcp_free_queue() synchronously destroys the socket, so they
> unregistered the keys immediately:
>
> __fput_sync(queue->sock->file);
> queue->sock =3D NULL;
> ...
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
> lockdep_unregister_key(&queue->nvme_tcp_sk_key);
> lockdep_unregister_key(&queue->nvme_tcp_slock_key);
> #endif
>
> However, a TCP socket's lifetime is asynchronous:
> in-flight skbs (e.g. buffered in a qdisc or device ring) hold
> references on sk->sk_wmem_alloc.
>
> When those packets are freed later, tcp_wfree() puts sk on TSQ and
> tcp_tsq_handler(sk)
> acquires bh_lock_sock(sk) on a socket whose lockdep key has already
> been unregistered and zapped.
>
> All other kernel storage/networking clients (sunrpc, nbd, cifs,
> iscsi_tcp, rxe, siw) use static lockdep keys without issue.
>

I think 19bdb70c77d3 should be reverted.

We can change TCP to use sk_gfp_mask(sk, GFP_ATOMIC) instead of
gfp_any() in tcp_disconnect()

This ensures tcp_disconnect() respects sk->sk_allocation =3D GFP_ATOMIC
and never acquires fs_reclaim under sk_lock.

WDYT?
