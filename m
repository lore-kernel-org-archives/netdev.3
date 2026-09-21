Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDBF4B66C2
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004833; cv=none; b=gI+l5YRaNPIu4IPITzXtVPX+agOs39fQZ4lFZPQ/UfvGnorwzKv+JlIb5oHCA8yGPWshYkTq4W8oNA/6eRePp3G6bXSocrB+VEKU3B//iDvugu2y1KX+akKHtdqbyrnsrN0c3eJmjFN9l/UYIeenkgyzLXe8RND7O23qOr5KnS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004833; c=relaxed/simple;
	bh=I7UesNNzihhfUM3T9kkjRfplteVqAEnYJpPI/ePgiEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNW6mc5mjTleOIV44cUFq4+aaRkkFgEQwZ20YakXYXgkHOS3FGjeNj3zWB6grSsiLUzH/QHRYn95sgyjb9bhQWqk1hsyO3tkbdKRvQjtFpXElz9Acfiy1DZjG8cV0jGttx+d68M9jC69BNokH9K7JXZaedCb/TyjJo91kABBfn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz0t2q82; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz0t2q82"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-482f63546c5so2470950f8f.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790004829; x=1790609629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ATQztYCMyMu3k6DnS/zHcGXiDiuEanDgsZ8XIDNR40k=;
        b=Dz0t2q82wSX3pw4NUPNIMWFDFyaMLzrpHR3XlMeTROMDG6hkfv3lKtMy+t8UX4DCYZ
         Yre0uZY0ohhZB/m8uZy+7NKSld+RQl4WeeH3lKWxRJDlI0jTU9kTZYktWnVPoRcdO0tM
         O02PStEdyvZA/1ewe3YZi37vUbtncXVXn3bg/EPbqaWhOYHpbpwP8SIbHTRblKzE9q7l
         nGBRSfYcad+DgIL8MobJBaUsECApzuOnQ/nsRfROKkFu03Gms5lDbF3Tihr3PUiStNA7
         M0LzqB6uep7UWHhTP43YO6bWVcjxoa7FsoT+/mFMmL/xcKoHjtxanaXNqCzWNQDUnag3
         +Amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790004829; x=1790609629;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATQztYCMyMu3k6DnS/zHcGXiDiuEanDgsZ8XIDNR40k=;
        b=gl5K5y9mbMYZcO/uvoCSuKtoJJntbDG+wUZ3r5RLqqNR3vgm7Bv8cSZHb3z7rewYOa
         nbBESf3iRILaMViRLS1Li8hDRZNqxi3l3wDBMuXOziQCThk8IGIU48VCC+c5o5LuVIU9
         muJY6rUJmS9+tnaxZuXpzA4AtDLv5uhzZN1K2Tkw53/sOqfk68v4jg+7Eld332reBs6H
         NagqMZk+hua5t8OOuSG4+zi1nLhUr1XkCfuwy9Ty2uLT8nAj0ERDz/1R2gko7UVP8/wY
         x7QLqt39hvQZaB6KNzMUrX5/eHKlP8+6eE9L06b+4+X6T2vvL7LS2+QGLJH1GHy96asN
         fAmg==
X-Forwarded-Encrypted: i=1; AKwUvBxNhRjjS7r8SCamlgnUHRCLOQ3JbTZ0Qb8RgPs84c52ChAixKhrnx9+b6BK/GyGqw92WoTtzGQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nHUWq5xfOCqLt1IfU733yZw+JQAzoVugmPlUB4VctvknkvW8EL
	fwvH8r2kOdKU7nY5e6eEoTod5JgN8wACZ3uZm31fyuJjrPpIpIKjYPEk4m5JIrbY
X-Gm-Gg: AYBFou2Pt+uz/N5sZxtRrowe3jJcDfCB0Zw7Vtzpmt6QaxASsEtbgByyJZJ7/o+GvRS
	z1oQ2Z6/OGBdovmlynfkuWanc/O1Jgm7x5D2fG14nOJr2nTJt+QTDufbyAcbsFUTc+hlpzAEGYe
	GXoxX/sLz05HQ86EedIA2yCkfKJG3iyYVNLZ+aja0vdQ65K66Hza4mjj9YG418rA7ONW1cMEtOn
	dxtrFJHer0M7DPXHBfF+3KCWfb6PyNXxKhnf9wUo15RUXyquNOWlpHKEtKW7bhzeyPjeGDpXWot
	RmAzbJKNPBUM0/3JiTMf9aeLMCQans3RfQu0QxxNv/nhuzEbNT/ri712+okmdpdo40fu+92sG/P
	UTR4U+i8w6XbMXhp9hNH09KaxOOnMldGSIVOlAzDzYgn3TEoj8ZKFS2t3JigmZ3wXmIiDbxaJvZ
	DpenqiBC34JnaZbE2USMWcUEDX2Nmdbe/jEQDvu9kK04M7uVTGJjPY6ZxQicFRc5QiER3OlWFTS
	13+nhqwQkM+oPgXi38h1jdiGzb7e5zqWmQj
X-Received: by 2002:a05:6000:38f:b0:487:c48:5dae with SMTP id ffacd0b85a97d-4871e21d900mr14510363f8f.17.1790004829281;
        Mon, 21 Sep 2026 08:33:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872446067asm24137495f8f.12.2026.09.21.08.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:33:48 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:33:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, "D. Wythe"
 <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya
 Jayagond <sidraya@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen
 Gu <guwen@linux.alibaba.com>, Alexandra Winter <wintera@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Hidayath Khan <hidayath@linux.ibm.com>
Subject: Re: [RFC] module: init-failure path can free a module with live
 try_module_get() users
Message-ID: <20260921163347.2630a6f4@pumpkin>
In-Reply-To: <2cd4adea-9b70-4951-be8b-40c1bcc7ecd6@linux.ibm.com>
References: <5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@linux.ibm.com>
	<20260918142241.55a6630a@pumpkin>
	<2cd4adea-9b70-4951-be8b-40c1bcc7ecd6@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Sep 2026 20:04:10 +0530
Mahanta Jambigi <mjambigi@linux.ibm.com> wrote:

> On 18/09/26 6:52 pm, David Laight wrote:
> > On Mon, 24 Aug 2026 11:43:46 +0530
> > Mahanta Jambigi <mjambigi@linux.ibm.com> wrote:
> >  =20
> >> Hi Luis, Petr, Daniel, Sami, Aaron,
> >>
> >> I'm writing to ask about what looks like a generic module-init failure
> >> lifetime problem in the module loader. I ran into it while working on
> >> the SMC networking module (net/smc/), but after several patch
> >> iterations, it seems the root issue may belong in kernel/module/main.c
> >> rather than in SMC itself. I'd appreciate your guidance on whether this
> >> reading is correct, and if so, what fix direction would be preferred.
> >>
> >> THE ISSUE IN do_init_module()
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >>
> >> include/linux/module.h has a long-standing FIXME in module_is_live():
> >>
> >>     /* FIXME: It'd be nice to isolate modules during init, too, so they
> >>        aren't used before they (may) fail. But presently too much code
> >>        (IDE & SCSI) require entry into the module during init. */
> >>     static inline bool module_is_live(struct module *mod)
> >>     {
> >>         return mod->state !=3D MODULE_STATE_GOING;
> >>     }
> >>
> >> Because MODULE_STATE_COMING is not MODULE_STATE_GOING, try_module_get()
> >> can succeed once a module's __init is executing. If __init makes the
> >> module externally reachable partway through and then later fails, the
> >> failure path in do_init_module() appears to do: =20
> >=20
> > It is rather worse that that.
> > If sock_create() auto-loads a module (eg sctp) then nothing stops a sec=
ond
> > sock_create() entering the protocol code before the initialisation comp=
letes.
> > That can be hit by two separate applications, I hit it from an out of t=
ree
> > kernel module and avoided the problem by putting a mutex() around the
> > sock_create() call.
> >=20
> > It might help by letting try_module_get(THIS_MODULE) always succeed
> > while blocking other requests until initialisation completes.
> > The code making the call must own a reference (otherwise the code could
> > just disappear), and that reference stops the module being unloaded.
> > That would let the initialisation code grab extra references (eg for
> > a worker thread) without allowing other codes paths enter the
> > part-initialised driver. =20
>=20
> Thanks David =E2=80=94 you're right that the race is broader. This patch
> addresses only the UAF on the __init failure path: once we set
> MODULE_STATE_GOING and call synchronize_rcu(), new callers see GOING and
> fail; we then drain existing refs before free_module().
>=20
> The concurrent-init race you describe =E2=80=94 two callers entering
> MODULE_STATE_COMING simultaneously during a successful init =E2=80=94 is =
not
> addressed here and would require changes to try_module_get() itself, as
> you suggest. That is the long-standing FIXME in module_is_live() and is
> a separate, larger change.

I suspect it is also much more common.
Module load doesn't normally fail, but if you can persuade the system to
unload an unused module I'd expect a non-root user can hit the concurrent
init race.

David
