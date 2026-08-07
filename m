Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976539B94F
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131856; cv=pass; b=IsOpMeQd9Zrn4z92JjFnUQ+/TVVC/1GKXw11cJKJ6fndm3+gaCcedjZl/7rInSoQ5kjTri6MBa/q4s+RAOuhbti8HyqH99qf8/xIirxdobvOvwep0hKuVPN9HdMGZOXdeLdDIzg5ilT4T+1q1I2WE7C45OBM4hNUFhLyzxa3yBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131856; c=relaxed/simple;
	bh=4xiLHxYkPGdiFvA0nrbU2tlQdfq82xczLJnzo0zXkwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQn//qkC2pUs3u25Q6hvJYb+dT07FyR3jxp0VZhZ6IO6As7ei5+yZhpIti3n1EkRtFlTGln8UBNZUCj/SxaBeifb3s2HVTkbcY8Umu2Uk2Sm+KE4HHfzXc+Y+IKgdiza0V2Ym2yAVCXSK7BQNOZf/iXkzDD2NtOCNDLGQEhARIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q80mHEg0; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q80mHEg0"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a2dcede83so5318793b3a.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 12:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786131854; cv=none;
        d=google.com; s=arc-20260327;
        b=I2z2lr2ILRtH4R9yA2F+fxaVoapOF5dG74z0iT/+/czGw8CRbDCaHVbuM4DhW0LnBG
         i8H5emWv6q9DDjNZ5sdSs91jKnZEdYrScSZ2RnxZOkcdnFn8tHFGxUb9gAuaYLB4FzAa
         BdS6Nib93JdPzwOZf6O8kYnD5m5O+Jmu4X0olsBANZg87C24xEY2XoiXFxGHwZIpOw66
         3qIb7h4uI3VAmNwQ2OI0ot8Pf+Mw0VVHVAUmHTe+/QPxVsZm4XT92/uHQq5ClIryDI1l
         IaY6vEaDiJ3EGEiSn31eqsD4fqK4JGUtqXM3iqw8mo7y2jTP3BuZ3HT5JfTL8hDs8xRd
         WeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e/wtoPuRy5LBbReY+YT0mukVCMIY6FSDljjCufXHkOM=;
        fh=mm/NAmbNYceH48CMEE2Ftym3JWoXa49TLhkNZowOkpA=;
        b=q3pSPomOZZRdZVjYUyzelENLQ5KM6H+L8Jy+6ASNB2CpDsRL0Xk6qiZfLPf7Zw7C6A
         ol+zqyiUWHiZKv+jVrRcnXFDPTmD+6OO4m6mW5v9WgsnL1i96ZXHuW92aORPMTBn5oyw
         34d9xnFYBnqF+YeDqY1VbpNlq+c8fR/5mqRH1zE9X1WKWXJJ7np1qjio1ym0MstOzT1F
         V7L0WuDU3jyZBsa1AX/cDDL6so/9aftY1F6tol878b0Sh1aEtxDqaaDjBy3lvXz+4PIT
         MoGZivi+wNMCkCD6WKRcBiX3wb+n/VQqIrUmqonH4zTmiZa/BdpYYd9xjHqu/ROrtO/m
         FoZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786131854; x=1786736654; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e/wtoPuRy5LBbReY+YT0mukVCMIY6FSDljjCufXHkOM=;
        b=Q80mHEg04QYmylKFoxCyDQK8pKqgOUTJGyr3fWCzTnohYdHTX28YRVl3Sx/ExN9eUM
         mZigsHsz/wm6vY6ko2X699jYd32rjwZOskPXMGb1EIg33N0DW+jJ5XQYVMwg11cS8zHE
         zZiTli8YJS0e4frkpoAcfFU9IArBK6LkV7L0UjOABb6wNLyVY6xYLw1qR5NHzPpMvkMM
         BRXs1FU7sJjijXBvIUBd+46PLEWNlrfySSbmR358Ssh+utSZLeAehRO5ys9AX5V6Nbq5
         nFVu/tyw0BPDKpeFuEhWiH9NMw8aCiT86rFhNYcpv2f7L1hSt7oK5J4tr+TEcNWMMbqF
         ZRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786131854; x=1786736654;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e/wtoPuRy5LBbReY+YT0mukVCMIY6FSDljjCufXHkOM=;
        b=CPkF8J6yPKJQMNFHXYAQyq93z8lpMfBnrAzeLlLzWEuB2FTFNpmbVroMvBBcFg89NA
         /E0CwQdVRjQzZbNtK/GVky8Agr4tTH3jpHcy8iDOuHapw9ztkPhBPFPEVbNJubP06Za0
         yEBEKeQbvZhL4C/3Z9z6SZBjt+NnsT8BUKT1Fq0UmNgjmWs6dGHk61HrE2T5oRaeoUBj
         4MSCP/GaopnluLEE2Mqosi8JXZAsa1pOdEU44C8tmum0q91aBIOeivBeI6m10OSdAZI0
         i3mKwcEi2XsMDhvamAk6CC4LNZOdJ4bbNtYcxgL5l/GHWbdPIkd8BLh2T8SqESegUSkA
         rfiw==
X-Forwarded-Encrypted: i=1; AHgh+RppBlKOShD3dUCEmHum818TCwELY2Ysa55vNRCOTZrutAJDpWFNnfWnx2gApGLHDqdFQzBJQFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxJR44M/Hq/dunaXhEP2qimbCltRh84jsR+TWUrx+Dt2gS+Sm
	c7RSZRkAxZHdCe215iBgaUlVFqWlAce9B+4pgXoraWkoB0u5JxGeN+IuejJxqBAK4wMRZrCCX83
	f3ZUXwmf30Ewj0MMj8k1ylKKvAZaPYXc=
X-Gm-Gg: AR+sD13MOi9IuDh4ubuqrIGESUyiNCE4KJd8eaxymsq6wCGvc3dCk2YQit7KJ4exXbO
	HisSe/KUmA86VAmL8AcFBflg3VPzqthsVbGQ3hukj0374QZ4p6wTOuk9n9055vl9UMqW+lfBycx
	J/iJn2DEXwGBN6mNTKIuj8yXShTOkg6vozgf0C3Nw1hkR65NcWqdSGqxnWhoXyanCibgrvaqmHh
	7oUi+liwGr5ADpSFx7E+j7xcaRv6gRDzbYEZp3Yq/XUBuNfxjgQkknmi+cWN2SDfs6mSwXZj9LF
	m6BJI3brBJpz5ZkTZkxG7E2GaclabMxKtPNMnlIR4BEE/KYDL5oioKyXibg8yoCWhzdYgZGatnd
	vlSJTBTmZdF0Ba4JBSyGPI87JNuAYpDza4Cwt2BcHCo8=
X-Received: by 2002:a05:6a00:2187:b0:843:49f0:f5a0 with SMTP id
 d2e1a72fcca58-84f5e0c4b15mr6824968b3a.32.1786131854606; Fri, 07 Aug 2026
 12:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806171614.945331-1-yangyx22@mails.tsinghua.edu.cn>
In-Reply-To: <20260806171614.945331-1-yangyx22@mails.tsinghua.edu.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 7 Aug 2026 15:44:03 -0400
X-Gm-Features: AUfX_mzVEiReFNJVEm_qbf2Gmz63c3XMP8OIwZQiLtSF0RDjxwSqyp76pzJhYwg
Message-ID: <CADvbK_ekVxEzb=-sbphAtmzYYXqfggWX2h3CK24s84MmQvahJg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix use-after-free of cached ASCONF chunk
To: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	yyxroy22@gmail.com
Content-Type: text/plain; charset="UTF-8"

> > diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> > index 5b0ae616e1ff9..737f8ea9d482f 100644
> > --- a/net/sctp/associola.c
> > +++ b/net/sctp/associola.c
> > @@ -1713,6 +1713,8 @@ void sctp_asconf_queue_teardown(struct sctp_association *asoc)
> >          sctp_assoc_free_asconf_queue(asoc);
> >
> >          /* Free any cached ASCONF chunk. */
> > -        if (asoc->addip_last_asconf)
> > +        if (asoc->addip_last_asconf) {
> >                  sctp_chunk_free(asoc->addip_last_asconf);
> > +                asoc->addip_last_asconf = NULL;
> This is a pre-existing issue, but does setting this pointer to NULL here
> create a NULL pointer dereference in the T4 RTO timer handler?
> During a peer restart initiated by an unexpected COOKIE ECHO,
> sctp_sf_do_dupcook_a() queues a command to purge the ASCONF queue, which
> calls this function. It also queues a command to stop the T4 RTO timer
> using del_timer().
> Because del_timer() is not synchronous, if the T4 RTO timer is already
> executing on another CPU, it will block on bh_lock_sock(). Once the
> restart processing completes and the socket lock is released, the delayed
> timer resumes and can unconditionally dereference the now-NULL pointer:
> net/sctp/sm_statefuns.c:sctp_sf_t4_timer_expire() {
>         struct sctp_chunk *chunk = asoc->addip_last_asconf;
>         struct sctp_transport *transport = chunk->transport;
>         ...
> }
> Previously this race caused a use-after-free, but with this change, it seems
> it will result in a guaranteed kernel panic. Are there any synchronization
> mechanisms preventing the timer from running and dereferencing this pointer
> after the queue is purged?

Hi, Yuxiang,

Please address the issue reported by both Sashikos in this patch by adding
a NULL check in sctp_sf_t4_timer_expire(), like:

@@ -6105,7 +6105,12 @@ enum sctp_disposition sctp_sf_t4_timer_expire(
                                        struct sctp_cmd_seq *commands)
 {
        struct sctp_chunk *chunk = asoc->addip_last_asconf;
-       struct sctp_transport *transport = chunk->transport;
+       struct sctp_transport *transport;
+
+       if (!chunk)
+               return SCTP_DISPOSITION_CONSUME;
+
+       transport = chunk->transport;

        SCTP_INC_STATS(net, SCTP_MIB_T4_RTO_EXPIREDS);

Otherwise, this change would turn the existing issue into a NULL pointer
dereference.

Thanks.
