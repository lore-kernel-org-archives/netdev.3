Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BAA4AD4BB
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991431; cv=pass; b=Mujhn1fbIABzKOZnwVTSyV6E02VMS1IIiG0DU7XUFE3L8YBD1L6/xkSNEl9wcmkyKZvG3rQtH4D5nLC6ay1hBJoeaI93gQp1oMgi4M93/pfoSRS1NRs0PD7rggqnYjZIpiLYqR2InsPxEiMHGWjgkzKQ0Z1CCXtIKKKTVOHnf5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991431; c=relaxed/simple;
	bh=AkA0IoTtitv/Q5oNBS2PcMfOk5urE1ejsZGSuHq9XUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPbt9t3U5Fz6KfhkFyrjARfV5fdVF1G/ztW8AJLzZlMXh7nvCEkNhUlTXCc1soWrG+3uiA44jb39n+jwBC1lOxz+gCi0G1j777F1+sCh24W2wMIk+a0t+QMEe20Na/SuatztbzmwHhZN8GDU+Or7t16CwXsKw5O0ThyNIidDfuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=vovvK30J; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="vovvK30J"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66de7e0bc85so5761762d50.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 15:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788991429; cv=none;
        d=google.com; s=arc-20260327;
        b=H9/GXMQav3SVbCGFFhjWkCGq4XjhunPbjasexKWMIRpH66tZBMXIL/npNzITrmW1k7
         jHovZ1cSDnD89KlYnPst7XEftSefow7/WpPSFSXFRoh5Kmo/8zEGuxF9ky8xk4wYezYJ
         a2frr3/nTtme80spePiOvUFWegN8SmiTIQLttw/gvXGwWk1vCXuHOsmGXDBJfjXgo/G9
         VPm2otSYOm1o2kVbsrvfwzWahvo2WRmC5dpEtHpDKJsClpd4CTQEJmnCGv5BNx9R2TbV
         FOj4flKpUcqadTZhe82NcUKRWcRNeBFj71VRIiJa1pIrsLFLbQvn3swo68l8RoWz+hi/
         qXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AkA0IoTtitv/Q5oNBS2PcMfOk5urE1ejsZGSuHq9XUg=;
        fh=x9RD/uT8B9rAhSsZVc5WklPdqCaNrPPzG5DIAG0U6zk=;
        b=meHBjOcaAiPKBOYbl/cWOtw0qnvxHF0ubgO5+nkfWZu9dc1Zd3THMKWYh8CZruu0OD
         J8UgezbdJRmiuSIKf1p8XRObq3ik8JQdWaNGjs/s3WyBZsqhoZnHW/e9clRMvp9xMnTv
         fRMhf0h8zO0EPdHQZtj8yzjdPef67ypGcO/oH7cmAyYbF4SwlsarENYVv7yd3GqyAJPK
         JZ3TRcPFToZJg+f81c9gugYivm7ZsFeweBCujuogown8sii8TH41oHtViK8ALmtwiaeT
         CgpcAZKFN9ic0j3QefcEr8Idm3z/6IDXWSwLRz7B2kVA61JG5DL/LvEaBFDE7a/GLTvy
         7oVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788991429; x=1789596229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AkA0IoTtitv/Q5oNBS2PcMfOk5urE1ejsZGSuHq9XUg=;
        b=vovvK30JGkLHhsOZnrORxiIcXi2pVWgUvQf8bYXzfJjlV9t0ds9yJbqbaRERx4NOGV
         Lv4Hfs9nLGcf5vcBLwNVEGKOE1aJuG2hJIyOwk90AhiCX0SgSZy504rqfCjCaDA0CoWM
         xZ3MWeTeWqTcaoFDy422iayY/zzeD8cG9s0m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788991429; x=1789596229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkA0IoTtitv/Q5oNBS2PcMfOk5urE1ejsZGSuHq9XUg=;
        b=oAigoAIjWHyZY4y7HCnIU0OJknWpKBPeWNbXFriNNShpW4yt1Ms2jd7ZHLV/BCQSzq
         z/vtlccuiY9YZHRtmni60sFKCzhZWt6WpRE/CRqTxTwkJsqhhuYtVqtV6/kZsjIxaz+Q
         k6NjrZ8bqfgLxrOFi71UfFvXx6bCfvLsGOxNkeLmUo3FAoPQvVUjvqptl76rOuAYUR/Z
         7ondD4WPVdPeBnzONObH5NFemwIZnKTYfiXzF5wGwR/mZ/yH6doRiDvQSYBbDJzJxCv/
         FlSglp8OrQw0zRnuAJlXXRbgQhoqLIW7rqkDT7wA9B8vOJjnnrMM9LFNVzgY/YlwNNi0
         vmjA==
X-Forwarded-Encrypted: i=1; AKwUvBzWfSPTAucjbkyuq2HuAcUM85ggUV3N1o0N+v+QqYiB2eprzCoNmbNnITZSsxKo6EOG1No+86Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mH02UTBOFvKrSkUmsWzHb6JDOFnhBQkSxnj0CrgmWE3+bjMMlP
	ZbYVuBM/GyZS3QY2JjOSb5rNP8XNPNcY2t3X9t+FeWR3tY+43KOKTX729SZFwv9lQr9Q8czvJED
	urHmZOjDR3km51/qnkfuQG8xIeK/ZfCDkY2pq36jn
X-Gm-Gg: AYBFou1YhH20BVMFd7kMfv4R1nonYX73vPlKB0NnwW9RJFeruV4cB5h0q9Hyr5+YuZC
	LCQ46bbBqv3c/bNpH+E365/PPPDA6fZhJ/+DcEcy1OFgWDXXVDIZRhSrcZ8NMdaGFLwrTOKN5Bh
	G40FQuNxfUwJVscG9c5K6TJ4ZHuFsy3V0usjL85ccs0fuvHS0Hv5I+B/TjAM7boE7w1DVOzfMxo
	/by5EsjcGNYQvwsysdf1nqqR8ljvBwEobzbRuSzR/X8k7UveMwWDPR5falSTk5NkFEbGVHxEUFK
	z0R9yI6/HNM4oXP4VaJ/8MF8LDRbX0SK+synKdhPACxmaxa5NluEfLaKzxU5diG9dHXyz0Z6Lot
	dmRynX5tY+P0Uo1v/oNkKLJrNiTwV2+BJAVA76w==
X-Received: by 2002:a53:ac93:0:b0:671:74c:4220 with SMTP id
 956f58d0204a3-671074c44c1mr2992050d50.27.1788991428630; Wed, 09 Sep 2026
 15:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908205537.863484-1-kuniyu@google.com> <CAM0EoMnFTMQPjy1kaSmgcaFzRsHHgZAH1zTGn4RvrrEzy62Qsw@mail.gmail.com>
 <CAAVpQUD6KVE9WmX442cazpF+WimZrN-kv_aU+jxqxCV_NXcA4g@mail.gmail.com>
In-Reply-To: <CAAVpQUD6KVE9WmX442cazpF+WimZrN-kv_aU+jxqxCV_NXcA4g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 9 Sep 2026 18:03:36 -0400
X-Gm-Features: AcwNN1U1h7ycUANR3HadGCjXwVwAtjYA8Bpjbo06oxNTQL5OtQNBYCK4s8rgHs4
Message-ID: <CAM0EoMmwXwd2XRBQkVc9p22cxWKGnwDuMGFUH7VQW_gLNbONww@mail.gmail.com>
Subject: Re: [PATCH v1 net] net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:47=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, Sep 9, 2026 at 3:01=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> > On Tue, Sep 8, 2026 at 4:55=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> > >
> > > If a netlink socket sends RTM_GETCHAIN requests repeatedly
> > > without recv()ing the responses, tc_ctl_chain() hogs CPU and
> > > triggers Hung Task splat. [0]
> > >
> > > As caught in the stack trace, netlink_attachskb() could confuse
> > > tc_ctl_chain() by returning -EAGAIN when the userspace netlink
> > > socket's receive buffer is full.
> > >
> > > The replay: label exists since commit 32a4f5ecd738 ("net: sched:
> > > introduce chain object to uapi") but was not used initially.
> > >
> > > Since commit 9f407f1768d3 ("net: sched: introduce chain templates"),
> > > the label is needed for RTM_NEWCHAIN because tcf_proto_lookup_ops()
> > > may release RTNL to call request_module().
> > >
> > > However, the replay logic is unnecessary for RTM_GETCHAIN.
> > >
> > > Let's apply the replay logic only for RTM_NEWCHAIN.
> > >
> >
> > The patch looks sane.
> > Can you send me a reproducer please? We are automating and testing of
> > all tc submissions.
> >
> > Reviewed-by: Jamal Hadi Salim
>
> FTR, sent the repro offlist and asked to resend the tag with
> the email address.

Thanks. Our system has tested this before and after the patch and
including relevant tdc tests and it is fine.
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: hybris@mojatatu.ai

cheers,
jamal

> Thanks !
