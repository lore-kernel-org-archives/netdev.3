Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C33C4B87
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244380; cv=pass; b=KYT9sOENhYFPiFAkvp6J8+P7oQDt0U2h+PmHpWu7NpEKkq9x/wa5KoWyQP6bqpNdqV1mpgQNN7QNwtrlMzvnsqYlC3hSlmj2pB8yszDBwVL74k0QPA3pnXJ/o/pJYd1W+H+FKd1munaiUh0+jUOwOuCNIkhH0Ut5RcE3VuNeBqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244380; c=relaxed/simple;
	bh=5PitEWE4LVtxfe2H74Csmay5+z32OyTcksU82m9HLNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXm5LDG04oykWiwBPK6FaLSD6jSptRglzpHxdTZgGRx/Aoi+sMCWUyt6sg4lTcBPaLPxUSBs3I27qaZIPDEAoj7k9jIrBTkDQq3+3eltxj4nOCo2O2gSLnvFDNRu/Gt8jPuZoldPeDbOMlKtsy8nHE/ps8tyWIw9KsSwxiSSjcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=vm8X+TPL; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="vm8X+TPL"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848593533cbso2823692b3a.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 06:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785244378; cv=none;
        d=google.com; s=arc-20260327;
        b=KTMiZUPF8YP7OOqMJa6XAQ552y4MB4LWBt1+wmJOp5nH/zLMe0C1GPdQTKCSa67XR0
         /c0uLg2cdW6h7BJai1snLshRSfOSFYnWoy6FZPxJPuTUpj2cHZ/MTp+zOrD6xHlGGWGj
         OKD9/dWtGZY3bzwFKn/YZH1tjxuYJclnL/Xeo3MAD5sWWdajM4iI2eQ2Gs+Q+1upwujw
         ROeWH5ELEQ4GSC4So071rbbW6qZZx6KvE2vr/ZLLnP5DjQWnFZTDCqh8uJk7EklFX3bx
         TCo/a5cJQ0jg1UUQyk9eBjoVYJoSnkzmWcW7oUhEe3Xs6zcTZU0/9odXDsB0ojgBOcR/
         5fXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RsLXOGn4ljM01hXnayTxvwBZ9s73EJ6kvuoyVSlCNSo=;
        fh=f7cUH0j2XkhKmpjCLO6wd3b0SZWBfkjaPRXI7cwW36U=;
        b=ILe1bTT0kzUgZ2O03adkYn4wxs4tbx/tCYd1I7WWkDVMprIUTn2WKDlrycczrldrPD
         89MEf0+/B+6sowhjjVU3T17aqpicUUutG1Ax1R4XR88K9MgoZIZT7O9oRymaLptmW3da
         Iy+7u7zy4Z1bAUb2mI0dm6M2FyTxq6CjtbuLWRXTXUQORb15vhlesXTHaW42i7T+VL25
         qw5DLnK9b/y8jpRJ69WZ97SB9qWi0m1ojKRFSiczr5asDve543LRE7KE/zuFoIOn3k6p
         /GxU7fhAKREGZLLi+lsFnXUz1le5hY3J1uQ8lK1Ynv1cCWuBLzAf5LzithXmexSX1qoL
         VcVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785244378; x=1785849178; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsLXOGn4ljM01hXnayTxvwBZ9s73EJ6kvuoyVSlCNSo=;
        b=vm8X+TPLZX/3TMm28ETsCWOl5VAAoKsjNxJ9TIXREX9djlK6gGGmiPebH4NWCjI67E
         WfRzVTe6JOswBNUbRinkHhIgltaSlDrIJohacJHIJeCU9BykVu37FJ01fKaiKiv7pZpv
         r0ePSGWhQT8rOxC2qgiLjcgqRBsrudY1bHjPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785244378; x=1785849178;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RsLXOGn4ljM01hXnayTxvwBZ9s73EJ6kvuoyVSlCNSo=;
        b=sjivMOEcA97ODfBKLj4FflQFT56+Cjk0eAKylLSzP/T7ICJEzpBM4Vh8jH4d3GkRc2
         CH20A/suL6Z0k96iki67rxfbtcUusvexAD1C1+X+3cFCJzkkcsg5OclZ6201rJYjGASX
         eQzxh8eStXiTBuJbch3bNtuOiG+hn++glP5Z4FPdDw24dD4LK1cORMLqZ0z7+6U1qMnD
         pgk50ZKEMwBsfb93QxJ67sIC27063Me6VE++6xNKGz26lHwcwG3JqjYoRIx4Mg3VtYMo
         Lm0z/v4ohk3MzbOe8Yxsr7BVuTkLgAcsW5ynPBX+ZjA9RqQdzMgKPYmbW3GxR2OxUkcc
         tDCQ==
X-Gm-Message-State: AOJu0YygLs41zjvnafZ8Yprh5V2iQVeAcyDrA/M9xudvn3dzxXZ8l1tV
	AvvFpTd2qpgVVSaxfRzJZCUP/obzqn3LdCV3bK+XGrFp3t4IPP1NFKFMJ+59C0BzKBJK6xLbpYN
	/yQdcy9KYMB68LtzLKgDuOy7gHpz20L0wt9JB73SM
X-Gm-Gg: AR+sD12jZbYY6pP41H3d9knApHkp+H8f6CUL2XCQBE0ISba+OOk0scv5YBhYoWY7lkX
	pi1PX4iyapsbpjALYA1EDBWD0nlGwfpCm4imsGtQcknqsTQsFr+ATT7t5l7zr+25HgvRZRuNX7Q
	M33GY0zqkTEKhkCYRMKj3x7o44d4HxjLQZncziJ67T7jy9Eq5k89clKEkwFMl+tLE5AvNVWMTAG
	/liA2m4l3cSuyHhfPzFegVdHPJ85rWc7/wPdT4yMIvuU4L7gnep8YPj5Pjy+DKvzJmK1bwCMDeM
	LRqOisq0TnbU292UJZLxPYbcWcrROx22ADetYG+ZuR3Ogg==
X-Received: by 2002:a05:6a00:21cd:b0:848:2f71:b657 with SMTP id
 d2e1a72fcca58-84e9337dd1dmr2417946b3a.66.1785244377878; Tue, 28 Jul 2026
 06:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723105210.817079-1-jhs@mojatatu.com> <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
 <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com> <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com>
In-Reply-To: <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 28 Jul 2026 09:12:46 -0400
X-Gm-Features: AUfX_mw1XP2-NPHioV06gzDgV5xM2e-PWrTVRmgQN5cosWlyvmNYVqUKt_wf0gg
Message-ID: <CAM0EoMkRMOBmrGW3fAcxxhTxcLaP44zr4m5Ds8G2VFT1CissNA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com, 
	jiri@resnulli.us, zdi-disclosures@trendmicro.com, sh.kalluri129@gmail.com, 
	victor@mojatatu.com, security@kernel.org, stable@vger.kernel.org, 
	Santosh Kalluri <santosh.kalluri129@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000fb3b0b0657ab9857"

--000000000000fb3b0b0657ab9857
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/28/26 2:37 PM, Jamal Hadi Salim wrote:
> > On Tue, Jul 28, 2026 at 6:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> On 7/23/26 12:52 PM, Jamal Hadi Salim wrote:
> >>> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> >>> index bd6f945bd388..700f878fc3cd 100644
> >>> --- a/net/sched/cls_route.c
> >>> +++ b/net/sched/cls_route.c
> >>> @@ -297,16 +297,29 @@ static void route4_destroy(struct tcf_proto *tp=
, bool rtnl_held,
> >>>                                       next =3D rtnl_dereference(f->ne=
xt);
> >>>                                       RCU_INIT_POINTER(b->ht[h2], nex=
t);
> >>>                                       tcf_unbind_filter(tp, &f->res);
> >>> -                                     if (tcf_exts_get_net(&f->exts))
> >>> -                                             route4_queue_work(f);
> >>> -                                     else
> >>> -                                             __route4_delete_filter(=
f);
> >>> +                                     /* Always defer the free.  The =
direct
> >>> +                                      * __route4_delete_filter() pat=
h has no
> >>> +                                      * grace period and races with =
readers
> >>> +                                      * that cached f in the fastmap=
.
> >>> +                                      */
> >>> +                                     tcf_exts_get_net(&f->exts);
> >>> +                                     route4_queue_work(f);
> >>
> >> Sashiko fears the above would be race prone:
> >>
> >> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260723105210.817=
079-1-jhs%40mojatatu.com
> >>
> >
> > That was fixed in v2. Is there something i can do next time (message
> > patchwork?) to not waste your time looking at an older version?
>
> Usually the tool properly updates the old revision status, but sometimes
> it fails do to that.
>
> Double checking that the old revision is marked as superseded in PW
> after posting the new one could help.
>
> >>>                               }
> >>>                       }
> >>>                       RCU_INIT_POINTER(head->table[h1], NULL);
> >>>                       kfree_rcu(b, rcu);
> >>>               }
> >>>       }
> >>> +
> >>> +     /* All filters are unlinked; no new reader can find them on the
> >>> +      * chain.  Wait for in-flight readers that may still hold a fil=
ter
> >>> +      * pointer and have published it into the fastmap after we unli=
nked.
> >>> +      * Then flush the stale entries while head is still valid under
> >>> +      * RTNL, matching the route4_delete() pattern.
> >>> +      */
> >>> +     synchronize_rcu();
> >>> +     route4_reset_fastmap(head);
> >>
> >> This really looks like quite a big hammer.
> >
> > It is.
> > I viewed  it as bug fix to original intent of 1109c00547fc - that
> > commit even though had the intent of protecting the fast map as as
> > well (based on the wording of comment i saw).
> > If performance is a big concern: another approach that maybe worth
> > considering is to totally remove the fastpath. It maybe more
> > performant than imposing the rcus.
>
> Given the amount of effort involved in rtnl lock contention reduction, I
> think it would be great if we could avoid the synchronize_rcu(), if it
> does not block the fix for an unreasonable amount of time.
>
> >> Since there is already a
> >> synchronization point for both reader and write while acquiring the
> >> fastmap_lock, I'm wondering if something alike the following could wor=
k ?!?
> >> (completely untested!!!):
> >>
> >
> > Your approach has some holes, example misses the most dangerous part -
> > destroy(), etc
> > I will mull over it and see if it can be fixed to handle all the
> > issues. I think it's possible i just need to put time to
> > validate/test.
> I would appreciate that, thanks!

See attached. Untested (compiles) -  addresses my destroy() concern
eaerlier _i think_ (unless something pops up in testing)


cheers,
jamal
> Paolo
>

--000000000000fb3b0b0657ab9857
Content-Type: application/octet-stream; name=patch-paolo-mod
Content-Disposition: attachment; filename=patch-paolo-mod
Content-Transfer-Encoding: base64
Content-ID: <f_ms4odzmu0>
X-Attachment-Id: f_ms4odzmu0

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9jbHNfcm91dGUuYyBiL25ldC9zY2hlZC9jbHNfcm91dGUu
YwppbmRleCBiZDZmOTQ1YmQzODguLmM2OGFjOThmMjA0NyAxMDA2NDQKLS0tIGEvbmV0L3NjaGVk
L2Nsc19yb3V0ZS5jCisrKyBiL25ldC9zY2hlZC9jbHNfcm91dGUuYwpAQCAtNTIsNiArNTIsNyBA
QCBzdHJ1Y3Qgcm91dGU0X2ZpbHRlciB7CiAJc3RydWN0IHRjZl9yZXN1bHQJcmVzOwogCXN0cnVj
dCB0Y2ZfZXh0cwkJZXh0czsKIAl1MzIJCQloYW5kbGU7CisJYm9vbAkJCWR5aW5nOwogCXN0cnVj
dCByb3V0ZTRfYnVja2V0CSpia3Q7CiAJc3RydWN0IHRjZl9wcm90bwkqdHA7CiAJc3RydWN0IHJj
dV93b3JrCQlyd29yazsKQEAgLTY2LDkgKzY3LDExIEBAIHN0YXRpYyBpbmxpbmUgaW50IHJvdXRl
NF9mYXN0bWFwX2hhc2godTMyIGlkLCBpbnQgaWlmKQogCiBzdGF0aWMgREVGSU5FX1NQSU5MT0NL
KGZhc3RtYXBfbG9jayk7CiBzdGF0aWMgdm9pZAotcm91dGU0X3Jlc2V0X2Zhc3RtYXAoc3RydWN0
IHJvdXRlNF9oZWFkICpoZWFkKQorcm91dGU0X3Jlc2V0X2Zhc3RtYXAoc3RydWN0IHJvdXRlNF9o
ZWFkICpoZWFkLCBzdHJ1Y3Qgcm91dGU0X2ZpbHRlciAqZikKIHsKIAlzcGluX2xvY2tfYmgoJmZh
c3RtYXBfbG9jayk7CisJaWYgKGYpCisJCWYtPmR5aW5nID0gdHJ1ZTsKIAltZW1zZXQoaGVhZC0+
ZmFzdG1hcCwgMCwgc2l6ZW9mKGhlYWQtPmZhc3RtYXApKTsKIAlzcGluX3VubG9ja19iaCgmZmFz
dG1hcF9sb2NrKTsKIH0KQEAgLTgxLDkgKzg0LDExIEBAIHJvdXRlNF9zZXRfZmFzdG1hcChzdHJ1
Y3Qgcm91dGU0X2hlYWQgKmhlYWQsIHUzMiBpZCwgaW50IGlpZiwKIAogCS8qIGZhc3RtYXAgdXBk
YXRlcyBtdXN0IGxvb2sgYXRvbWljIHRvIGFsaW5nIGlkLCBpZmYsIGZpbHRlciAqLwogCXNwaW5f
bG9ja19iaCgmZmFzdG1hcF9sb2NrKTsKLQloZWFkLT5mYXN0bWFwW2hdLmlkID0gaWQ7Ci0JaGVh
ZC0+ZmFzdG1hcFtoXS5paWYgPSBpaWY7Ci0JaGVhZC0+ZmFzdG1hcFtoXS5maWx0ZXIgPSBmOwor
CWlmIChmID09IFJPVVRFNF9GQUlMVVJFIHx8ICFmLT5keWluZykgeworCQloZWFkLT5mYXN0bWFw
W2hdLmlkID0gaWQ7CisJCWhlYWQtPmZhc3RtYXBbaF0uaWlmID0gaWlmOworCQloZWFkLT5mYXN0
bWFwW2hdLmZpbHRlciA9IGY7CisJfQogCXNwaW5fdW5sb2NrX2JoKCZmYXN0bWFwX2xvY2spOwog
fQogCkBAIC0yOTcsNiArMzAyLDEzIEBAIHN0YXRpYyB2b2lkIHJvdXRlNF9kZXN0cm95KHN0cnVj
dCB0Y2ZfcHJvdG8gKnRwLCBib29sIHJ0bmxfaGVsZCwKIAkJCQkJbmV4dCA9IHJ0bmxfZGVyZWZl
cmVuY2UoZi0+bmV4dCk7CiAJCQkJCVJDVV9JTklUX1BPSU5URVIoYi0+aHRbaDJdLCBuZXh0KTsK
IAkJCQkJdGNmX3VuYmluZF9maWx0ZXIodHAsICZmLT5yZXMpOworCQkJCQkvKiBNYXJrIHRoZSBm
aWx0ZXIgZHlpbmcgdW5kZXIgZmFzdG1hcF9sb2NrIHNvCisJCQkJCSAqIGFueSBpbi1mbGlnaHQg
cmVhZGVyIHRoYXQgc3RpbGwgaG9sZHMgaXQKKwkJCQkJICogd2lsbCBza2lwIHRoZSByZXB1Ymxp
c2ggaW4gcm91dGU0X3NldF9mYXN0bWFwKCkuCisJCQkJCSAqLworCQkJCQlzcGluX2xvY2tfYmgo
JmZhc3RtYXBfbG9jayk7CisJCQkJCWYtPmR5aW5nID0gdHJ1ZTsKKwkJCQkJc3Bpbl91bmxvY2tf
YmgoJmZhc3RtYXBfbG9jayk7CiAJCQkJCWlmICh0Y2ZfZXh0c19nZXRfbmV0KCZmLT5leHRzKSkK
IAkJCQkJCXJvdXRlNF9xdWV1ZV93b3JrKGYpOwogCQkJCQllbHNlCkBAIC0zMDcsNiArMzE5LDE2
IEBAIHN0YXRpYyB2b2lkIHJvdXRlNF9kZXN0cm95KHN0cnVjdCB0Y2ZfcHJvdG8gKnRwLCBib29s
IHJ0bmxfaGVsZCwKIAkJCWtmcmVlX3JjdShiLCByY3UpOwogCQl9CiAJfQorCisJLyogQWxsIGZp
bHRlcnMgYXJlIHVubGlua2VkIGFuZCBtYXJrZWQgZHlpbmcsIHNvIG5vIGluLWZsaWdodAorCSAq
IHJlYWRlciBjYW4gcmVwdWJsaXNoIGEgc3RhbGUgZW50cnkgYWZ0ZXIgdGhpcyByZXNldC4KKwkg
Ki8KKwlyb3V0ZTRfcmVzZXRfZmFzdG1hcChoZWFkLCBOVUxMKTsKIAlrZnJlZV9yY3UoaGVhZCwg
cmN1KTsKIH0KIApAQCAtMzM4LDcgKzM2MCw3IEBAIHN0YXRpYyBpbnQgcm91dGU0X2RlbGV0ZShz
dHJ1Y3QgdGNmX3Byb3RvICp0cCwgdm9pZCAqYXJnLCBib29sICpsYXN0LAogCQkJICogbm90aWNl
IHdlIHVubGluaydkIHRoZSBmaWx0ZXIgc28gd2UgY2FuJ3QgZ2V0IGl0CiAJCQkgKiBiYWNrIGlu
IHRoZSBmYXN0bWFwLgogCQkJICovCi0JCQlyb3V0ZTRfcmVzZXRfZmFzdG1hcChoZWFkKTsKKwkJ
CXJvdXRlNF9yZXNldF9mYXN0bWFwKGhlYWQsIGYpOwogCiAJCQkvKiBEZWxldGUgaXQgKi8KIAkJ
CXRjZl91bmJpbmRfZmlsdGVyKHRwLCAmZi0+cmVzKTsKQEAgLTU1OCw3ICs1ODAsNyBAQCBzdGF0
aWMgaW50IHJvdXRlNF9jaGFuZ2Uoc3RydWN0IG5ldCAqbmV0LCBzdHJ1Y3Qgc2tfYnVmZiAqaW5f
c2tiLAogCQl9CiAJfQogCi0Jcm91dGU0X3Jlc2V0X2Zhc3RtYXAoaGVhZCk7CisJcm91dGU0X3Jl
c2V0X2Zhc3RtYXAoaGVhZCwgZm9sZCk7CiAJKmFyZyA9IGY7CiAJaWYgKGZvbGQpIHsKIAkJdGNm
X3VuYmluZF9maWx0ZXIodHAsICZmb2xkLT5yZXMpOwo=
--000000000000fb3b0b0657ab9857--
