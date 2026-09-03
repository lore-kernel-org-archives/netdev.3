Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC34AE139
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444052; cv=pass; b=a/jeB0QIFV+P9W/p4Bw7aeqi3k31GjDZey0GYgptXYYq6j6+KyWZQFmeMvfsSj1MAHZC/N78RsYHlUx3jgapQI/JVRjg34KZqgTHeOFdfGs9HoIJrl0b23VttoEojvj/wGdfBsK3ID4hJDFuvhuNPpsyDhds0tGy9/AgcdZHR6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444052; c=relaxed/simple;
	bh=d+nV/y5gzHZQbqpaWid3gzG6rgbMOVarLaEROjaG5PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVChHPrBNqAdy8XCMOcmc6MUWdJ889CBFzaMjwzpvXVxz9ZMMjJ0m2XY+9hWPFELZCBspQfOyFE4350tPmBtshYqnSYpoJulJYqvdOnLmX72Xidrr074k+kNEgE9Tt5slzmqOeCcw9uRk+GqZ9w0vxfvAM5bVUt4uO1DHfi90vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8p5L1OD; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8p5L1OD"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso2659253b3a.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788444039; cv=none;
        d=google.com; s=arc-20260327;
        b=hq8Q3EobCZFcheO8zoFpGpaDH/Z3l29VNSAG9aqhOlY/vlAwvI/QIMukr8NyCek+/T
         iYhe3tAzdf0yhIzbD7cQraFo2F31q+H6jM+fvTmDtk1Y2jp52hU2SswHNHo+64gajGcZ
         2NUbSlEXv4hiGuDvPNmKdFtzeRC33Ff/S3IA3nmC9cP4q//9QFg4v28dMQmBT+TK3X2P
         Y1noSxp/Ek2JnPuIq5A0vGKW3uK4Il0sP3VwFPvGCa/GOj07KPNMRiDhEHYGKaidaQW0
         JBIgzbpEUsecApTaIBniSWzfTfhFY37Lkil03rbE4AI98KQy9muNyNC/QeFXFWFywaSv
         vW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EZlAVxnc61vhxXdUOKLatLp9Jvhf8iA3Pl5Y4/hX8c0=;
        fh=iAgYwaxi5FwNzG8HcVkdrD8Y9X5M+A/nOkx0G2Fiyto=;
        b=bV/bW6wHdmhg275adfyEOASlA+NggfIyz2yBND24zC76Yr1Huf1STXETPoqefirBYV
         /IZdD7oayHXdPBTP8y6d78UsqBQSb1y2ys0tHIAZ85e9zLSDIHTG93Lqa8Hfmf5Y127x
         jTjLv2hympwyK92ufM3PUntEiOUbalOsipbXzAYs6cucjOtEAauWvX4WdGcBShNfIr4J
         6SGQ48k3wE86UhqevEYCza/gSx+fVaTaQ43aFQQCQ4ECh3b9Zo9REtiqhDIv+HmLEzqy
         uMSPK32BLa5MggYVX9zbYgA47NgZKUoyRM+2WipU68rfVyX4zMcziEIzNr7f9I349CBv
         0pHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788444039; x=1789048839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EZlAVxnc61vhxXdUOKLatLp9Jvhf8iA3Pl5Y4/hX8c0=;
        b=r8p5L1OD1zg2BEvoWoFE6FQelMcJX4eTXDhsmg8c4+zW9SFVHqTMj460yDYBK9546Y
         EZOVuowRo6oSWMcJBSxiIIrKdUwDgRMxQfVK83+v54CGvvmjSBee4yUsW+WwNtNRIO7l
         didwu6gogazquktaeH4IHhe2udrlidgvPZ4yAzu+wK8GVNauEe6DAxF1LMPR0r/JRD8L
         6rhaLKwktFgSGat8Lf701vYST43eJeh2XcL4oqHeFtc9T28ErP5jWV61jrElGdhIxI5p
         XdJVaWqO82yPTVsHPf2cuT0IEiwhh4P/NqziedbtcN7XhfbC3E0nCCMqNDSlvZOfUKxo
         fF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788444039; x=1789048839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZlAVxnc61vhxXdUOKLatLp9Jvhf8iA3Pl5Y4/hX8c0=;
        b=EmhTZbTw97IhwRuE0p4sbrVYeD0b/zBebGDhfrvezSDcermGtWt5kDQmFELlYTDhhk
         XEJGBaVNx+ObY3GQJruJKaWrVQ2VFd0EywiCcXTLdUg1Ln1ixIgEl5azwTt8aR/vg+HV
         qwnCpsplOE8muH7l9J+1oj1oHm+ZfrSpBs8L+2dn88itLMa9L18VUsnfubh46v7LZ+4+
         SpPsApOPvpifMzP0b0++MGUfjssmw0NneAb5mdrBZWMXRwUkVDOVuyOsHpOTW+yYt3jc
         ibbDSG8T2i0qgKsdBmVlMxTRJKxP3479HSKoPO3t+aFlIlGNisag1oeQ6iHc4kKHjOOH
         t8ew==
X-Forwarded-Encrypted: i=1; AKwUvBysimyRv0ChlTpyAOvwFIYM5io7b+Oy3BLPJHmtOe+by/dMysrRZJrBwVxp09ArnMmw8REiByA=@vger.kernel.org
X-Gm-Message-State: AFuF++nrzEZUlH9dxnqBUg4zjsLqu0ZBVzHxPqRWDueOdA2niZmTb7aX
	ex7vZbh1RED+CD8oa7bSYE25nOVQdzvQ3bophjVMuJ2jpi6WzybnGCiRj/Z7etRSctcr6YfPnNk
	C+8UFQa5dOsTHQOzlpsIQJBN+2R2OZt4=
X-Gm-Gg: AYBFou2jmjR90+tiy/Chl8a7d+UovMFGwUwrrLNE8TdZZojYjgooI5EBgo/ei0uV+Y6
	XqbzQPXmK/b5hZcWZwgjAMLgwRk3aoxam23gZzfJNgpHDctF/vy9POlRCj+RtmQ4Ey7Vf/l8ppX
	Z5KUj3cUGk5O8atv06L+Qvp58UXwHaW7ja95RI6unQjPYEnsmaZRen7L6NGx4TuJJ12IgHX2gHO
	lEkr+NSDqAdPX11L4YhhB6qZlA8KgaJu3b0XJKa7yOlYjV/BRTZgRPDEvhfMSOUxorZA5M21VE4
	7RWAJHgfWGXfmGjIWRmq0awDBtybFkye82XuMg3vrPlGZMlu/HVz8RUGr8jhoitrPsxpSeE9U01
	sFvePcKgFzKcnW9QBzOd/9SLJSaPZrmw+/gywgeZfNiWB
X-Received: by 2002:a05:6a00:88a:b0:848:56ff:6ced with SMTP id
 d2e1a72fcca58-85ed7d20475mr15597002b3a.8.1788444038911; Thu, 03 Sep 2026
 07:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a7d8773.c5ad36c8.12f49d.002e.GAE@google.com> <68cb4941-3668-44f1-a889-6b2f023b2a08@h-partners.com>
 <CADvbK_eY4S1HbdNHuNq9b=Va-TA_6rNFvnCvtOUZ0sF-AWN67A@mail.gmail.com>
 <20260901153524.3e92df3a@pumpkin> <CADvbK_esKpvPWK0xipKeiDr6KDiAL2_uPOhrREOMMVjJ_ndK7A@mail.gmail.com>
 <20260901224645.7c5bd2e6@pumpkin> <057c057f-be11-4bf7-9403-f454bb2864c9@h-partners.com>
In-Reply-To: <057c057f-be11-4bf7-9403-f454bb2864c9@h-partners.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 3 Sep 2026 10:00:27 -0400
X-Gm-Features: AcwNN1XUrJ_FTmvwVEbrN9-ZuqD8a_Bm6_RE7fP6GlRGhmJiGfJcoIWsRw_q3mI
Message-ID: <CADvbK_eBx0AicxxWXE1ZOqeNUJtU2YPgTynthBkhq3_1jks9iw@mail.gmail.com>
Subject: Re: [syzbot] [sctp?] WARNING: refcount bug in sctp_transport_put (6)
To: xietangxin <xietangxin@h-partners.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	syzbot+80dfcb1a2235b3efc877@syzkaller.appspotmail.com, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, marcelo.leitner@gmail.com, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, gaoxingwang <gaoxingwang1@huawei.com>, 
	huyizhen2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:23=E2=80=AFPM xietangxin <xietangxin@h-partners.c=
om> wrote:
>
>
>
> On 9/2/2026 5:46 AM, David Laight wrote:
> > On Tue, 1 Sep 2026 11:06:31 -0400
> > Xin Long <lucien.xin@gmail.com> wrote:
> >
> >> On Tue, Sep 1, 2026 at 10:35=E2=80=AFAM David Laight
> >> <david.laight.linux@gmail.com> wrote:
> >>>
> >>> On Tue, 1 Sep 2026 09:45:42 -0400
> >>> Xin Long <lucien.xin@gmail.com> wrote:
> >>>
> >>>> On Mon, Aug 31, 2026 at 11:47=E2=80=AFPM xietangxin <xietangxin@h-pa=
rtners.com> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> I have analyzed this issue and successfully reproduced locally.
> >>>>> The race occurs between the timer callback (`sctp_generate_heartbea=
t_event`) and
> >>>>> the transport cleanup path (`sctp_transport_free`):
> >>>>>
> >>>>> Task 1(Timer Softirq)               Task 2(sctp_transport_free)
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D              =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>> sctp_generate_heartbeat_event()
> >>>>>   refcnt =3D 2
> >>>>>
> >>>>>   bh_lock_sock(sk)
> >>>>>   sock_owned_by_user(sk)
> >>>>>   mod_timer(&hb_timer) -> returns 0
> >>>>>                                           sctp_transport_free()
> >>>>>                                             transport->dead =3D 1
> >>>>>                                             del_timer(&hb_timer) ->=
 returns 1!
> >>>>>                                               sctp_transport_put() =
(2 -> 1)
> >>>>>                                             sctp_transport_put() (1=
 -> 0)
> >>>>>                                               sctp_transport_destro=
y()
> >>>>>
> >>>>>   sctp_transport_hold()
> >>>>>     -> refcnt is 0, increment fails
> >>>>
> >>>> This should not be 0, as the transport must hold a refcnt to start t=
he
> >>>> hb_timer.
> >>>
> >>> Isn't there one hold sctp_generate_heartbeat_event() and a second for
> >>> whatever 'task 2' is doing.
> >> Right,
> >>
> >>> When hb_timer is started it is given another hold (does it actually n=
eed one??).
> >> You mean mod_timer() in sctp_generate_heartbeat_event()?  Yes, as it w=
ill
> >> release the last one in out_unlock, it must hold a new one.
> >
> > But can that ever be the last 'hold' that actually calls sctp_transport=
_destroy().
Sorry, by =E2=80=9Crelease the last one=E2=80=9D above, I meant releasing t=
he previous
=E2=80=9Chold.=E2=80=9D

If the hold succeeds after mod_timer(), it can never be the last/final hold
that calls sctp_transport_destroy().

However, in the current code, there's a window between mod_timer() and
sctp_transport_hold() at [1], sctp_transport_destroy() can be called
to  delete the newly enqueued timer and release the previous hold.
The hold at [2] for the newly enqueuing has not been taken yet.

  if (!mod_timer(&transport->hb_timer, jiffies + (HZ/20))) {
          mdelay(1);  /* [1] */
          sctp_transport_hold(transport); /* [2] */
  }

> > It the timer is always deleted (as task 2 above) it doesn't need one it=
self.
> > Might need to be del_timer_sync() so that it waits for the completion f=
unction
> > to terminate.
> >
Unfortunately, del_timer_sync() can only be used in sleepable contexts.

> >>
> >>> So when hb_timer is deleted it's hold is removed.
> >>> But the del_timer() is happening before the the extra hold is obtaine=
d.
> >>>
> >> Ahh, I can see the race now.
> >>
> >> I remember you mentioned holding it before mod_reduce() in a previous
> >> patch, maybe it will work here, like:
> >>
> >>                 sctp_transport_hold(transport);
> >>                 if (mod_timer(&transport->hb_timer, jiffies + (HZ/20))=
)
> >>                         sctp_transport_put(transport);
> >>
> >> Does it make sense?
> >
> > That should close the timing window, but is probably inefficient.
> > Rather depends on how often the 'put' ends up being done.
> >
Each timer enqueue must have a corresponding hold. As long as we take the
hold before enqueueing the timer, there is no race.

> > David
> >
> >>
> >> Thanks.
> >>
> >>> The RHS (task 2) would need to hold bh_lock_sock().
> >>>
> >>> Try giving sctp_generate_heartbeat_event() two holds.
> >>>
> >>> David
> >>>
> >>>
> >>>>
> >>>> Also, the delay below is under bh_lock_sock(), so it should not be t=
he
> >>>> real cause of the issue.
> >>>>
> >>>> Could you share the PoC for this issue?
> >>>>
> >>>> Thanks.
> >>>>
> >>>>>   out_unlock:
> >>>>>     sctp_transport_put() (0 -> -1)
> >>>>>     -> refcount underflow warning!
> >>>>>
> >>>>>
> >>>>>
> >>>>> Adding a small delay  after `mod_timer()` increases the reproductio=
n rate:
> >>>>>
> >>>>> --- a/net/sctp/sm_sideeffect.c
> >>>>> +++ b/net/sctp/sm_sideeffect.c
> >>>>> @@ -373,8 +373,10 @@ void sctp_generate_heartbeat_event(struct time=
r_list *t)
> >>>>>                 pr_debug("%s: sock is busy\n", __func__);
> >>>>>
> >>>>>                 /* Try again later.  */
> >>>>> -               if (!mod_timer(&transport->hb_timer, jiffies + (HZ/=
20)))
> >>>>> +               if (!mod_timer(&transport->hb_timer, jiffies + (HZ/=
20))) {
> >>>>> +                       mdelay(1);
> >>>>>                         sctp_transport_hold(transport);
> >>>>> +               }
> >>>>>                 goto out_unlock;
> >>>>>         }
> >>>>>
> >>>>> Any feedback or guidance would be greatly appreciated.
> >>>>>
> >>>>> --
> >>>>> Best regards,
> >>>>> Tangxin Xie
> >>>>>
> >>>>
> >>>
> >>
> >
>
> Hi Xin, David,
>
> I have a syzkaller execution log that can trigger this issue.
> Please let me know if there is anything else I can do.

Hi, Tangxin,

Can you try if the change below will fix the race?
(You may add mdelay() back for reproducing)

diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index 94716406d602..c0fddd5e8097 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -378,8 +378,9 @@ void sctp_generate_heartbeat_event(struct timer_list *t=
)
                pr_debug("%s: sock is busy\n", __func__);

                /* Try again later.  */
-               if (!mod_timer(&transport->hb_timer, jiffies + (HZ/20)))
-                       sctp_transport_hold(transport);
+               sctp_transport_hold(transport);
+               if (mod_timer(&transport->hb_timer, jiffies + (HZ/20)))
+                       sctp_transport_put(transport);
                goto out_unlock;
        }

Thanks.
