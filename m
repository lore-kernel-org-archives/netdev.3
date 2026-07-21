Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237C83BB678
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622030; cv=pass; b=MZ6dyotBxturUXQ+QY8DrKmoq2slQYhWs9HvpCroNx69Fq8pU0e1xei4ClH72UoiD34sWlN5RSoOrPYMApQOfABsE+++dqF3D+i3MRElQHcZn00r8ceXZK1HZwIOt1onwvMk+x9w5w/DeEwGeWFSF1O7gkNHqG9H2RdeiMo4ECs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622030; c=relaxed/simple;
	bh=ztrUEJqTV0EtgBon6330FP+RblmnI1iFcyDNyIluav0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYtz3X0bVIVuwqPCB0RxLpa6sETFVkFl30qUdMtpyfa+5pavlWjOEhxQ/FIzYATsFc0U7H3FX1DeevOTdgVhDi6rZEgoNoIcJbJ+CzOXvKJfwpBaxh6CMRnxb98kCUlh9SyldzoXbhMNpLRGHQs/ZGoFD8ih/c5JUN0JxSbr9L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UbJ9tijX; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UbJ9tijX"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39ca0a30148so91877551fa.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784622027; cv=none;
        d=google.com; s=arc-20260327;
        b=hA4T+fJZExNsmMjeApUGRoDUBGNGVZYkRJ5Wm7JzEtKYv3rySXUdya5BIO/nz6Z04o
         YhtNStEQIq37eZpPWp16DJH6p62Q53pe0FJBV93Rf6PAbyVYIySKrRcYjmHmtxmy2rrg
         2qjM6FpLHjAtDdb3gOIiWaS/LBzI/YgKgzcptQBMdDlBRhCb3w3IyCH6AwKFBHte+uSv
         kja1Eco1nll2La45fhb2+Mo8bu/CyHJOBLZMx8RYu1+uWkkE58pzQpg9cW8Ld9WZfhCu
         q8lSUWSve88Hoy3bdpPb75WOu/QgBFl/6QPvS1evcQuKKTvKFGHxcE8kIV+8i0hprI04
         HO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O2Pbh7OmOV3uoNdc1QIVjc77f5fG66z5eYomiH01xPE=;
        fh=eIJVbZsVDgFJ+KThVOvWL1n0yzmupWJVj5Fmza/nT78=;
        b=DZzI3Ba4+6bKxUFEBM9osjDohAJlsd/1ShonXArAkZR9rDFLWW2VOMJExHcYKaKRh4
         1zKn5VgqXVeVJzD94LU/FUb81Zqm3DgyN626KguiZCWhoKUM1XOyodQYm4nOekRZTDUV
         LBj7Q4N1y/ZeOvNDXc/pU7VoGiiKQlXU+GeEQO0futT4oYmx6HJJWOaAXD4JUHOdHHOS
         XtVHIDhXqV5cXcEMf9XYO+Gmq0Gd1IWWu/j8K7fGJ0dKfCIwy5OLMg0VKXAMWHbP6/5n
         linDYzFJDzjz93RlvLabBn39oWxUWnUeUQ37Otrr0ZwtHTQE+Xa9mcZbfUCT52d4z986
         KLHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784622027; x=1785226827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O2Pbh7OmOV3uoNdc1QIVjc77f5fG66z5eYomiH01xPE=;
        b=UbJ9tijXvusNuNvCKgqKR9hS1zamVB621Ca8skzt4FGXIBEP1ISJCztgCtHDHZ/6y5
         86xphKo8e2/ViBRtUE67BNeWFlSm3Os8vcZDwiYRriWo10Z9B+tsVKPP1lDM7BL1eBt/
         nCTUo+Lz2rKus5/ls8iRvZiJZRK1feTfidabPB0JQLw43j5suE8cVeqUwZD/goB7qKHm
         s7hMfrdghZzJ+oXHe8Z+9jhhfoydJRHRiJL6GICzAZNOyFsd39VrZKPJXfcJuekWrjtp
         /I3/RMRjJ9T5OSW42wJiwAIGaPibwgG2i4MFIm9dOyRR1cnRlCI9AY0CpTu9uoYda2O3
         CVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784622027; x=1785226827;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2Pbh7OmOV3uoNdc1QIVjc77f5fG66z5eYomiH01xPE=;
        b=MnKVIHKMddpsld1+UGQejufXufIlGY9RRK15AV58CSINRLDuWtz7pn1INoNAZC5SMy
         WLd+aAD6XIr08KxCp+EwGs/3do6dMqCIEPEEXUVLh5T5ueuIDMlxLd9lccBnOto6jkIq
         3YU1S7TxdyPjgbjhJ4Z0R+mZKnbsQKh8uwgh0E3fd4SMGcdFI57mgYhZfAEPeDt5T8LX
         Hni3ze1rYXgOW/5/47RYvpvw+8DjVN6YBSA+8a3yGFNeQWC445moGmq/+dT3njYHPM+O
         vbUAsdrTfxDP3vvI92BN+dq00kubapZxZKi0DSTJdhMTBP+o+owGfYxVqFX8L15O8hz7
         0pcQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSCqYfWD6V2NrWJ/9B9Qfxii/6hKqdptYYMx1ybzItt/GdLbwi3HkRVFwF6FSx5rx4rRQhzGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqMAX+pmHWRyPEGYXS7+/ab3P+6XKe9W3E9oQQYBg6dYDWbjPx
	rmI9jr3+Zj3YDrsfbSAJnKVibdCj9RXPAIHOhhZorI6U53a99E1+bNIc0YAx8piBM+fbF6zSUkD
	LBzHVMqIHd+1F2XnORSg1qY2Cg9G2wa61tn/KVLRuCA==
X-Gm-Gg: AR+sD139UseIVWUZtQOyE/hiy2X8SgDACmxLLWjSRkhDCSC8OvcSLH1z9Oml9No817q
	k30J/qqelTndBZteDoQeSZm9h+6C40dgqJR6WXB2MHdRO8ZEUZS95olsgTh7QF6YQUiCBOoJ0Po
	hy9/16kRlTPVERpTN317AFGQ3IXBs74lA/NbEYVl23rTja4gQc/bEjnbxU2C69WuYZMqDz140ww
	NOOxJN1hH7SBNxltw4ky7tJYW/mqj8vPrvIvqyMHXCyitXMbWRxIXyxFjII6+MVXqFoSidhEfbB
	XsYIcBRvNYkNiNcb3rg=
X-Received: by 2002:a05:651c:220b:b0:39c:f58e:5c8a with SMTP id
 38308e7fff4ca-39eb28a5c35mr38335621fa.21.1784622027240; Tue, 21 Jul 2026
 01:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720100902.155605-1-marco.crivellari@suse.com> <e1e391ca-7085-4151-832f-bf187491089e@intel.com>
In-Reply-To: <e1e391ca-7085-4151-832f-bf187491089e@intel.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 21 Jul 2026 10:20:15 +0200
X-Gm-Features: AUfX_mw8jzNIsYCSTxLdPSkj2sFk07DpzC9NvPEOJrAeXW-C3ek6cIfVdozyo5M
Message-ID: <CAAofZF6-JM9MQvfGEkempwNg-kqZeE-esrtpq6YPJ7RW2xobAQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 0/6] net: Move system_long_wq to system_dfl_long_wq
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Haren Myneni <haren@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	MD Danish Anwar <danishanwar@ti.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Mika Westerberg <westeri@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Nick Child <nnac123@linux.ibm.com>, Petko Manolov <petkan@nucleusys.com>, 
	Richard Cheng <icheng@nvidia.com>, Rick Lindsley <ricklind@linux.ibm.com>, 
	Roger Quadros <rogerq@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 21, 2026 at 12:35=E2=80=AFAM Jacob Keller <jacob.e.keller@intel=
.com> wrote:
> [...]
> > system_long_wq is a per-cpu workqueue and it is used as a parameter of
> > queue_delayed_work(). This function schedule an item that it will later
> > be enqueued (once the timer will fire). __queue_delayed_work() does the=
 job
> > receiving as "cpu" WORK_CPU_UNBOUND:
> >
> >     if (housekeeping_enabled(HK_TYPE_TIMER)) {
> >     //      [....]
> >     } else {
> >             if (likely(cpu =3D=3D WORK_CPU_UNBOUND))
> >                     add_timer_global(timer);
> >             else
> >                     add_timer_on(timer, cpu);
> >     }
> >
> > The timer is global, so can fire everywhere, and the work item will be
> > enqueued where the timer fired.
> >
> > Since the workqueue work doesn't rely on per-cpu variables, there is no
> > obvious reason that justify the use of a per-cpu workqueue. So change t=
he
> > workqueue with the new system_dfl_long_wq, so that the used workqueue i=
s
> > now unbound and can benefit from scheduler task placement.
> >
>
>
> Ok. So if I am understanding this correctly, the current code uses
> system_long_wq which is per-CPU, but is fired using an unbound timer. As
> a result, whichever CPU the timer triggers on will be the one which
> selects the work queue. From there, the work item will be enqueued to
> that work queue and remain on that work queue until resolving with no
> way for scheduler to adjust it?
>
> With the new change, we schedule on the system_dfl_long_wq which *isn't*
> per CPU, so the scheduler is free to move the task around and
> reschedule. As a result we get better overall behavior with more input
> from the scheduler, instead of effective randomness from the timer which
> is then forced so that such long running task cannot migrate?
>
> That sounds like a pretty good improvement for the cases where the
> queued work doesn't depend on any per-cpu behavior. Nice!

Yes, that's pretty much it!

> I am not sure I can speak to any of the individual drivers here since I
> wouldn't know whether moving that particular work item would be
> affected.. so feel free to take this review with a grain of salt :)
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Sure, thank you!

--=20

Marco Crivellari

SUSE Labs
