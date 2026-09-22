Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6253B8BB6
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108669; cv=pass; b=YmRtRlxOj/4Qr7vOuTB4XTMMe16OYyWy+w2kfZ6ADB4rnJ6MAyNTQ9IWydWnD0q0HFBWEppHIH5guC/bS8yBA/M+BiixyHIN+pajxNUm3VHjKELHgvTlz+oin/7xcFXPVpzIRVu3fxDWQ8MSB3xa6wD4AlcMneWx0JY/IWi9Bvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108669; c=relaxed/simple;
	bh=+sfK3/3ZZLF+ZbTCtO0+5guiWMUXrvSJ8jXz2wEwafs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+FbHn4rO2ilk0WQqlyCIcWpXT7Ryq9fsQrNSmCJqadZu/4YceVoFlFTqxWDrJ5Ey9HshzAlG5Rh3mqLXkW4C7ikk0qnGLVMzlJu7haRENpyzpbIM9+5GYYLLRKL8xBiZ8910ydWAB41fAaIUjB9+jcDdFGe2Y+HKC4LMeYiVM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk0NHcbD; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk0NHcbD"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6bcc0c495efso143249eaf.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790108650; cv=none;
        d=google.com; s=arc-20260327;
        b=WVwJq5kLhjiZ3X1zJQW8g8eTrS5pwEOj8OV/0MmG8G1Q0gzu5J+PsjN6JIhjWfcXLh
         AIvxXStaK+jI+BbRArLqaosYMvL18RXaDUQKXYNpx2VmvPyXh9bcFcFWpb/zFsO7pgf1
         n1WYxi2x2w+BRenJTC+dpBy7Bgvbe+pwhAYXiFupULlap56V6f3s4sXSYQTE91w5SJP4
         Vmx9vv9cmkjXdfDC6Qf968iYo5R+f98C7/vK6XjGbzPdtZ+U0xDIacqnx7M+IRrT80Qx
         wXf26EiNCL+va5osMx6haBXVdgrUyzyvnYplRDhTiLDHV3f/7H7CTt1geYFWwHMdSF5Q
         5j8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MGlxY/stF9UV9Yd5mArTkSQ33aYUoCNMkwZq4NryLYc=;
        fh=WnBwU7wUFalknE2F5mezfTtJvbJu0fxiF6oXJMo6IOw=;
        b=V1l+JzOe2AspaHI0ohWY7SnHS8aSAYOhnVtE1Njj5BN5V/9mUtiGyqSz2YQRXNQjv2
         byRzeMWd2feutndMuUAWaHuLLocXcDES0RRAiefZO1qRFtK5jbJAMU5tjRoMUPCiNrQG
         GNbGw1xag3eSVQVJ66SIvbtk0KsvMyvfPAnsmdRY27qpI7GZsOX1QBR8QhMSziM7HCin
         pDAdzKf/uKEz63Dn73cgTl2puxd7hAUDOpZt3vSul8hNqMzIvGzBy6SbDVw6l6wSFsn+
         scrgzXGcLhOrS9m/7Q8Ww/08aEFvJSoXyljZasY1cc52EqByYczPIg3l9eJS4ipNSCTS
         V/Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108650; x=1790713450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MGlxY/stF9UV9Yd5mArTkSQ33aYUoCNMkwZq4NryLYc=;
        b=Zk0NHcbDSuljmxQ/1VUDrRiCB5dLvex9ZCcpBWXOVe0dAdF3mQUeJEHqY0oD1eO7X9
         6F1TxssewITq1gtquVFmyB4oOAgvgFr9Tjk/1jzXdAf2pldk5Njkf+fvz5QzD4bR+e0e
         Ov+Msy9TN2u3X3ymxNaedMn8sQgUdmjywjPcu1gRihdGSmVj6bVBxeLpoGucDMQjZKAq
         q4Q9ECV5ekOTAJmlvvgAkAZxoUs+/EQBfcqwiR660H9WXLNJUhFRrSg0cGhBZx4zOFge
         qRzo6qXkjvydz67Bmha7/hSF8gw+Zr/kPLAHvRpxcXZvufgSNuaUab04GFvxMtE4ZzEw
         ynyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108650; x=1790713450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MGlxY/stF9UV9Yd5mArTkSQ33aYUoCNMkwZq4NryLYc=;
        b=QNKG7K21KeIYLtJ6hXId5jXFtW2RLQAYDWAafRAoeKUirOsVK8a+jKdpUAlNpprpML
         uo2ClSIssO1vIL/93QJ3GITDZ7NAfAhzBuqMr6JgLFxCJbyuKUtI1vAXGE4XBaLfy+2H
         lNKXnZ+e5KvtEIAfqNm1Yes+WJFqB4j09dHD647RlpCpPwjflP1wfQUoR6JfZpIqx9ya
         Pv3HmlGCg5lTfSkFB1pPZanFVvi2m8u33ZKjf0bJyVWcd13ZyCBj3dKFc12ZfoTTCsbt
         5DzurrQow6xGhdWSi3vH5i3Wrs81roffLGavra6954JYtePK7bllHrMOzTllxB1ry8Cj
         1PpA==
X-Forwarded-Encrypted: i=1; AKwUvBx3Abx2MQCbih7JqMP0jrzPXyqbpobZzbx9eAURkoIIQNlYCigbPTiy/eGFa5XiEzpwS1a1Vaw=@vger.kernel.org
X-Gm-Message-State: AFuF++mLDBKj/7/IkMtSrf3yBAcemqWMTb8GF0vxXzSitfSOpjhwBEiC
	qIfT73WoxHon1bRFM2scQcV35Ekoxhiid46Iz3H5NAtTJBX9gAsSpsqummqY/ltIrV/gIPG1yVE
	UQS3InGXvgDQwf7EomPAxI+PZ5OsNZTc=
X-Gm-Gg: AYBFou0GTNUqH1NjRLwkRKegv7wHGlWjz4wKfUdnmeDkR1qAPLEoibV9DKEWIJWHE/Q
	xfgIqq04AvIzJVmdIhlZfAwLSK6Lry17LCHHoQ0sqRKKlLnddH2l4MTTefdxYZdqGJbPPRGpbHh
	W12u1asshzScQtke0LVCWQ/faXCvMUlyncGN4EkDW8FKpY79wNJVqYryZ1DMDTYXsjAkjavdMZm
	fi2TaVRBIQh8hfUT4FQV5gAUyFBXSx+KtbacwzZoLEQBXkDLaXIEgO/4jL3A5kUOqYRWtxqYqFo
	Xl0bvw7oPzyU01dKPAz7w8w1zQvcnGWJboYGcg6ROs/M3Bhglfd+SANhvJI5wqwoWfj1MwuHVNv
	3sZraSw==
X-Received: by 2002:a05:6820:c91:b0:6b7:8415:d786 with SMTP id
 006d021491bc7-6d2d261c823mr453823eaf.49.1790108649854; Tue, 22 Sep 2026
 13:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922172028.6269-1-emil@etsalapatis.com> <20260922172028.6269-10-emil@etsalapatis.com>
 <DLM2H0M84V64.3DRNAWAWXR4FZ@gmail.com>
In-Reply-To: <DLM2H0M84V64.3DRNAWAWXR4FZ@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 13:23:56 -0700
X-Gm-Features: AcwNN1W5N_KIAWLFVCBSFDm-7vSGi6EFTLU4zBKjmbFVIMO1UfWu6-IsRp4hrsE
Message-ID: <CAMB2axPbLQhGq-LRLzW4p27YVMowcv0XLdF6gNrLn8U3mG_fJA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 09/11] bpf: Track whether dynptr type is known
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, daniel@iogearbox.net, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 11:49=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue Sep 22, 2026 at 5:20 PM UTC, Emil Tsalapatis wrote:
> > The TYPE_LOCAL dynptr type is used for two different
> > kinds of dynptrs in the codebase: Those that are created
> > locally and backed with a memory region, and those that
> > are passed as arguments to a global subprog, whose type
> > is not known at verification time. The two kinds require
> > different handling in certain scenarios, e.g., packet
> > pointer invalidation. However, there is no current way
> > to distinguish them.
> >
> > Add a new field, type_unknown, to bpf_reg_state's  dynptr-
> > specific state. The field designates whether the dynptr
> > type reported is accurate, or a placeholder for "type
> > unknown". Adding an extra field to bpf_reg_state avoids
> > unnecessarily splitting TYPE_LOCAL into two types, since
> > they would behave identically in most cases.
> >
> > The change is currently non-functional. The new field is
> > first used in the next commit.
> >
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >  include/linux/bpf_verifier.h |  2 ++
> >  kernel/bpf/states.c          |  1 +
> >  kernel/bpf/verifier.c        | 27 ++++++++++++++++++---------
> >  3 files changed, 21 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index be0ccad15..f57730d1d 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -71,6 +71,7 @@ struct bpf_reg_state {
> >               /* For dynptr stack slots */
> >               struct {
> >                       enum bpf_dynptr_type type;
> > +                     bool type_unknown;
>
> why extra bool? Can it be another value in enum?

Second this. Could be a BPF_DYNPTR_TYPE_UNKNOWN or BPF_DYNPTR_TYPE_ANY.

>
>
