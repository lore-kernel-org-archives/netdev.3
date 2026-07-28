Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317438F659
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257499; cv=pass; b=JeZjo1YeX5gmCgeSFMCD3FhFQ6tanFQeFL5eIJ80ZT8pJ39ep0SFhMUFkepnpwg2wz739Afm3PfptZLuZzh0t0ZYG/SApi5NURHhirykG3+/F3kdELwxuEfkwyw0VvDRr20Dctm7vDsVnrGDV6Ftp7sPYR2Z21tWCHhPyxnoyL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257499; c=relaxed/simple;
	bh=vlD0TW0KXHEjUkZjxNFErtOjxLeUd4BbAcVOw+5MSDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H50YiWeXwV4/omwQjdlKvmSEQT7k5DSh+fiz5rptopaCDyLcAh2nyezYSWILrkOsM03y8COk3nn60DlLwTBcfpWgKc6pASBwS6XnzgKBgYJTatBWaVucEpYDk+10OhME1MNFvhX48vpNMylS1dBctC9ilP4L16wiY6BWwsjmCIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=tq9myjKe; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="tq9myjKe"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso59620b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 09:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785257497; cv=none;
        d=google.com; s=arc-20260327;
        b=FKKmsEpdlSmlr0TQmxDZuSTJU3J3nkLqrjXzklMq/3aGQbniek7dfq1XufGBJzvM/m
         /bXQd8uZij8b2yLs0brvGtJC+o9HQ2PA0cQyJeGbHw5KJBWVF9pKrLzGbird+PElzeoT
         K3l08MDuiG93xTHy9zeWK6kEBczj67TKp9aBZ4YpB2Fimdp1gWlxZX762WsuAR1JczlF
         MNfYtLasIsM15Srik3K7w+8fsSISFSNRVuyw8J2nctBqo5pK/tIF7UloeHUfx2bnNb2V
         XwG2AxWcK8u/dFjw5h3tVxI4SC7ESJziSDrCnV4NBPVf2eeT3+v3ku9zUHHBQZ/U/lB+
         VAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c4gjizotrYOWGcATMUoxDzqOSa24S+nV0QnHF/CgOH8=;
        fh=MCdzM/P1A3sh8JRbWRNuPeT0hq5akmgQuSs/4CQo9gs=;
        b=Q+Nrct7Ax6xas1yBNFOOYOCoUMgwqPi0jf7f2mGDNr8iXdVDci4Aed5qbzNs76G8vq
         26tb2aaRaWE7ERu6yG1mbh7mVc1BrrQ93w/d87HdSeo0+1FxA8UpI9c1i2RTVUWMuPbJ
         Ae5hsMwYDHcxwSspUei79YA911IfbrvFVuO7p3bWK3uwva4aZ1P5M3BjiJnK9M4DvC4C
         UPT1JiUMlAl9seShGM5gEXNsdCuIe40Syp82LC413VbnNzq0yV8q+UZ/53bTQt78L8n/
         i5ZpzYEtciyY7DRLoc6OnvaA2XqrEy3TRE1aM4SBPf3Nrx+tTu2cALv+SYTW9BS1VlmE
         f0wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785257497; x=1785862297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c4gjizotrYOWGcATMUoxDzqOSa24S+nV0QnHF/CgOH8=;
        b=tq9myjKec0FjmGjHXgEC+vXKu+KEZlzWYOdZm/ljvBInYotcov7trSwA2ceH/hqV1w
         Xi1A3iS6/NwJoXTLeeXkN5NrXApkAO6ymTLA5cxcwRB3M/bKipmCBesSkJvrPx/kvHHM
         FvMfhFyu6fcBOtYwqGVpJelC3UMuHCHqZwUPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785257497; x=1785862297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4gjizotrYOWGcATMUoxDzqOSa24S+nV0QnHF/CgOH8=;
        b=h5eGAxZ7AEmpspuPv+KhMbEXh5HX7dlYdTMFee5MJvX8cWTY4h6xHT0LjxGCzQyedV
         w3neBh1ticOAVkSPBr3SvRHg4cehai09cg5gfyTtYCBhn23mkQnghQ+VftVKaqypxgwS
         TtjAay9fTWa+xMaNX5680wIK8QFTh6/iBTPXGkoE4HlAfL42btV8crUwcee5y7yg8O/l
         +/IdbDwVwoJ7T89b9Tj/zosKTLPm2CMo69jAVoX1WA+4W27dat83eAgqhPrSOg9DFPC8
         dNTsgJeacaltLSHAmZOsrlDE0gksy01ULppdDRoN3/iK4RvF/o8d8DYn+Sn5svGF97d9
         e1KA==
X-Gm-Message-State: AOJu0YyuQNEqMghx4daqb08Emu5HZj/73wppD0V/kJs4Bac2hBDYT7tT
	gTRFmCyeArsdcN20o+wCo3ZNeu5Sfsb3O/jQhLOO6ihLw8UNKi9zav+6AFyjlayfwr1VlB2i9Xe
	SEbcDJWQYl6KvYUIxN03qX7U/1LpFH12H3akNd5fX
X-Gm-Gg: AR+sD13bEA46JkTtKRDYNWJqromANgYPRD/2uNXZYE65UHPR5Ndt9KuxKi3CfJOJBTY
	csZ2Se78QxDhhMP8nQoG30ekkLElF53QfiaFPWPL6NvyrNGPTNue+vcLo/wy4N7PPvMxpQdKHe5
	qt/g9HPnRwvYdnw0K1TIwKM2dfFL85co98hyV6lu7TpbzkmHsSdeOCq+osqmT25EJrz1FudJd30
	TH65of/jvYaEkEvv0XUGaier182PSJUsK1x0IX+DIGq5DmYFqdOFm2Cp0A804w=
X-Received: by 2002:a05:6a00:4fcc:b0:848:88e6:95d3 with SMTP id
 d2e1a72fcca58-84e933518f4mr3777982b3a.72.1785257497186; Tue, 28 Jul 2026
 09:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723105210.817079-1-jhs@mojatatu.com> <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
 <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com>
 <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com> <CAM0EoMkRMOBmrGW3fAcxxhTxcLaP44zr4m5Ds8G2VFT1CissNA@mail.gmail.com>
 <a4bda84e-3041-49b7-8863-e09862b2739e@redhat.com>
In-Reply-To: <a4bda84e-3041-49b7-8863-e09862b2739e@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 28 Jul 2026 12:51:25 -0400
X-Gm-Features: AUfX_mx0A7dQcsiQj4fXgfq4gfSwDd_OPj-5fXEqK1RqmLfIYeYu_SXvtZ6RBvw
Message-ID: <CAM0EoMntwBbw7ADoaX+KibvPHqmsPgt2yQpQpNzSMR4JzA7D-g@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com, 
	jiri@resnulli.us, zdi-disclosures@trendmicro.com, victor@mojatatu.com, 
	security@kernel.org, stable@vger.kernel.org, 
	Santosh Kalluri <santosh.kalluri129@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 10:03=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 7/28/26 3:12 PM, Jamal Hadi Salim wrote:
> > On Tue, Jul 28, 2026 at 9:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 7/28/26 2:37 PM, Jamal Hadi Salim wrote:
> >>> On Tue, Jul 28, 2026 at 6:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>> Since there is already a
> >>>> synchronization point for both reader and write while acquiring the
> >>>> fastmap_lock, I'm wondering if something alike the following could w=
ork ?!?
> >>>> (completely untested!!!):
> >>>
> >>> Your approach has some holes, example misses the most dangerous part =
-
> >>> destroy(), etc
> >>> I will mull over it and see if it can be fixed to handle all the
> >>> issues. I think it's possible i just need to put time to
> >>> validate/test.
> >> I would appreciate that, thanks!
> >
> > See attached. Untested (compiles) -  addresses my destroy() concern
> > eaerlier _i think_ (unless something pops up in testing)
>
> FWIW, the changes LGTM, thanks!

Tests on all PoCs worked.
I will give Santosh and Victor a chance to test and will post the
patch tomorrow.

cheers,
jamal

> Paolo
>
