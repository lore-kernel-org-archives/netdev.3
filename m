Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB93EDE63
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108904; cv=none; b=K0DeYDnjRkV8ySs5Wd0kG0oFFFtN6yB22iMPSZ/BkAEZM357Nvl5bYkq30aL0OvyFs1jcAchUaJa8ckQUvGezXORJAjIcE6uZ82i8UQBJI4I905Xq2itGxPlcb5Bdf0pZKPOrw8NjdpKrmRJd4BU3kR+h+XHSNZyuxIggzgV90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108904; c=relaxed/simple;
	bh=Fji0HRzHvqxcQeEBfQJE0uUG7PTXA9ehLCdLYpVq5Vs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=bq+zEfs7jmcu9Bm0vlUrZrV18T5OthuyuirmDlB5JAegZ95bndkqY2xir17t2yxgi3R6H2Sr5gm5jDltQuTKXcsORP5bKbssm/SdNT8zwPdSqI4Da8+q9VlQ4cTXyVuzP3XvTqI5yIsp8D39rLCSzuhTZ8q3PNB8haeCyhaTXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=edFqkwTb; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="edFqkwTb"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso934435e9.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790108896; x=1790713696; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FRw3oz69t2vAuwzTn8J01kFIogSh59Vp/4+7uQqF6OQ=;
        b=edFqkwTbs6XUtkDtmoZFGMprSjr4MBPiFrv3VodnNbISuR8qF/uonFkByM18Z/PoER
         6Q62vvP5IgZwIqWm5WlzsOWXzcSW1v0L4NrxZsgIdA9jmWW5Y1m7HsApZT374RfZ050+
         pVFxlfTbPdISCvCxwJ0JGIwA9nTpLzbHuUiP/ClHtD/R2LcVsSEmg13EOHxVl3Pc6YZk
         Vf/Rmrp3D1eDcwWUETZzz/adh9C3JgpH7lKbhvlhfNatDXZbgJmPzWPydw/U2qrlEz6R
         OIcyVoV/wHYHNXNJXU4lnNiiyfHSYnfup+uWI1esy7vKaBgeqlRNM9g1oIAvYaT8S9Fs
         c+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108896; x=1790713696;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRw3oz69t2vAuwzTn8J01kFIogSh59Vp/4+7uQqF6OQ=;
        b=0aPhCMARGxos+efHCH4hRbJBptjZshDyUJ45dsRz1jDuauLQ2ICq0xjohb6c38krup
         dd5nYFqwnjdudFTHo4Isyud/UAUuw8oL3YpHL9ADTT5frI4xGZ16I74iN2IaFDnP94km
         f/jTj9z8btCTcYV1VWyYdIlmhOYePTeTqw6TbQ7EZfWxkiYUXBpRhlkFaacI6YnKPU0w
         ZcayHdeSURev+2wWfK0E+uZvypK7+s1Hsp4XLraUTykro/f9EQpLm5D1Y6FAdhXhKgfo
         Mj49fmJvsWVaVN80MJvbCtxRN4aSWsLJ+TFVPbNZZ6+uWLxyrpSknCAnTDBIXii3SiAq
         BnaA==
X-Forwarded-Encrypted: i=1; AKwUvByKm0DwYf3wUOMMdp2PqmtwBxi6J+TArP//CVM5VNPXh4GRbABzUReaRpTZwLPOMiOIPGyKmfA=@vger.kernel.org
X-Gm-Message-State: AFuF++m9x/AsbCKXvUKcmw3TMnKe6CDuEGHHpRSbKSKdS0e2wX6J+ZQs
	t1Q8aGiiwXEx21A1AWlHKCD+luwdACreCfHPefKHoqLEpbPzSs+Jlj/DMNslpH7eaVA=
X-Gm-Gg: AYBFou3+UEfhHcKgtqENMQ4G6LYri8+EW+Tpuvpn18430LhQttG+UcCflVa3e+DM4YK
	WqPsZT/8emBoj4JO4c5dccHDgAiOE26fPsgOTcqWJtHN4qQtRhGfBpLjv2LQuqnkdB8ZLoyngcu
	cbfhkgdPmt6UyP89PnZ3++zLGTm+BCUTesmqILP4BgPFJPBMKxGgJEn9xU/Dr9yzdr+0tVSJDFp
	RRLfKklo40bcbOjElHqvI/SQ5WaoyG5a2V1cSfG2J7f42t6RvhQL1KAN8kSSs4T/n73f0JACElc
	XWo53jkqz6C9FJN+AQGeIF3bkpL3hZCFCsNHNZNFfc4DOVo3A6HSjVsbD6qv6JPkDhDmoi7ndCv
	jneoPhZk1h4jiYtATLIl6thEubXIz2I8zKddLbXv3JHxSRjo0VtRGRmP2bCiWh1XSOpjAiVdvgK
	pRsY87imjGsEdTG1fFKhoR06S1dV3tFKrfh+e9qdDzleuu8DuQywMsWbc=
X-Received: by 2002:a05:600c:1d1f:b0:49f:c199:e1e2 with SMTP id 5b1f17b1804b1-49fdf1474demr4570545e9.28.1790108895692;
        Tue, 22 Sep 2026 13:28:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:2ba4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684863fbsm844100f8f.11.2026.09.22.13.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 13:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 20:28:09 +0000
Message-Id: <DLM4N2XSQ4LE.23XSEE8I96EK9@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf v2 09/11] bpf: Track whether dynptr type is known
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20260922172028.6269-1-emil@etsalapatis.com>
 <20260922172028.6269-10-emil@etsalapatis.com>
 <DLM2H0M84V64.3DRNAWAWXR4FZ@gmail.com>
 <CAMB2axPbLQhGq-LRLzW4p27YVMowcv0XLdF6gNrLn8U3mG_fJA@mail.gmail.com>
In-Reply-To: <CAMB2axPbLQhGq-LRLzW4p27YVMowcv0XLdF6gNrLn8U3mG_fJA@mail.gmail.com>

On Tue Sep 22, 2026 at 8:23 PM UTC, Amery Hung wrote:
> On Tue, Sep 22, 2026 at 11:49=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue Sep 22, 2026 at 5:20 PM UTC, Emil Tsalapatis wrote:
>> > The TYPE_LOCAL dynptr type is used for two different
>> > kinds of dynptrs in the codebase: Those that are created
>> > locally and backed with a memory region, and those that
>> > are passed as arguments to a global subprog, whose type
>> > is not known at verification time. The two kinds require
>> > different handling in certain scenarios, e.g., packet
>> > pointer invalidation. However, there is no current way
>> > to distinguish them.
>> >
>> > Add a new field, type_unknown, to bpf_reg_state's  dynptr-
>> > specific state. The field designates whether the dynptr
>> > type reported is accurate, or a placeholder for "type
>> > unknown". Adding an extra field to bpf_reg_state avoids
>> > unnecessarily splitting TYPE_LOCAL into two types, since
>> > they would behave identically in most cases.
>> >
>> > The change is currently non-functional. The new field is
>> > first used in the next commit.
>> >
>> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> > ---
>> >  include/linux/bpf_verifier.h |  2 ++
>> >  kernel/bpf/states.c          |  1 +
>> >  kernel/bpf/verifier.c        | 27 ++++++++++++++++++---------
>> >  3 files changed, 21 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier=
.h
>> > index be0ccad15..f57730d1d 100644
>> > --- a/include/linux/bpf_verifier.h
>> > +++ b/include/linux/bpf_verifier.h
>> > @@ -71,6 +71,7 @@ struct bpf_reg_state {
>> >               /* For dynptr stack slots */
>> >               struct {
>> >                       enum bpf_dynptr_type type;
>> > +                     bool type_unknown;
>>
>> why extra bool? Can it be another value in enum?
>
> Second this. Could be a BPF_DYNPTR_TYPE_UNKNOWN or BPF_DYNPTR_TYPE_ANY.

Sounds good, let's go with that. The reasoning behind the extra bool was to
avoid having to add TYPE_UNKNOWN everywhere as an extra case statement, bec=
ause
the two enums would have identical behavior except for the check added in t=
he
next patch.

>
>>
>>

