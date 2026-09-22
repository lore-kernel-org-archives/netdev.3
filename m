Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C13A1A23
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087728; cv=pass; b=koIhthe9Hqqnx0dyOM7tPEA7Z/hBZi/zIciDH6dtzEc6J03Prn8ix7FFNEQ6dzmu5KI8dXNE2e2QbLxKAanjlC54zASMcmlWcYO6zRtI/bJj5TdM5L4RfWjjGcs7V8TGUTSTRxqprUhCf/I/IikDQVePRNhbGChkA+5lZQgbz4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087728; c=relaxed/simple;
	bh=NEyIVmq/MepCR0DVp6TI3+6kKc1aiUn/+ROhgJ5gksg=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEK/wHLSWoPoy0WBzfhV1Lr14t8RddjA4JKjfUREHzN9BzCsnyCtBNXL2saNPFYACb9pD4oRLE0gICYD1NTylqClsvHcCqlbWMFJvLYDeTge/adk7uW7W7xkhczDYzC0ZEJ2tesm1pyWOqFWf7dHtfR4UeCwFe9OwI1dfxzBdzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbNcnKpX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6tjeKWH; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbNcnKpX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6tjeKWH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790087725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gK1S9WSj9Xr3eZwZT3BugPd4DtS8wZ7bJxT3IFUTmCk=;
	b=YbNcnKpXkQCzeYPQRLp76xmekPlNplIhoaMjzoDqxnhXWheywLE7UoKf05Ncmvxq6Qq4qZ
	ykShcN9ajRGFzeLHeGmgiq7pLZKzxZVQYb98RAzAHh8gepZ7iG/NPvdTfOXXV2mCg2eA1z
	ei2GDRISRIVeamLifupRYvb3jilgZL4=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-wEoGqbhMO5C2ecnA5Pob_Q-1; Tue, 22 Sep 2026 10:35:24 -0400
X-MC-Unique: wEoGqbhMO5C2ecnA5Pob_Q-1
X-Mimecast-MFC-AGG-ID: wEoGqbhMO5C2ecnA5Pob_Q_1790087724
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-98331b577e4so3227537241.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790087724; cv=none;
        d=google.com; s=arc-20260327;
        b=lSF+cBhseAoxrRklZRp6goG4mgNffvK3ewWEAL1Vhcx6ost+q9SHVppGHVbSKBZ+xD
         Sf+FFvn2D6Sda3JKQu5gQ0JQ5RCamm0B7Yzyt1Ao0zQdpTdUx2ndBkMAwmU+5EvARfRA
         czhkfgEojceORQEJOv45Ul05SdM/PPBw5pECy4EbJxWIW9oynhmwYfm+aU+6xxz4txr6
         8Buzg4m2w2hDVzUFb8XBstKvfM4UxHh4QGrR/ZN949TNbEI1dKBBkt4pbOqMU/rRrDNg
         e7JTQPPS8wmezhC5WiRfMRssFdThXM4Dn90OrgjTJ44Uvs0uGBNLgfnIR2JWEfnXYKpA
         vdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:dkim-signature;
        bh=gK1S9WSj9Xr3eZwZT3BugPd4DtS8wZ7bJxT3IFUTmCk=;
        fh=LCPqGhZrnBKqiqaofh5uGt+N9wS0p0RbHeUkBytWb7U=;
        b=lYPCQIwkCx3r5JCumF8IG+YQgcI+5aH2b4O6IGd+IKxJp8yVY5ecmLLlX9YhzKCQne
         yz6VrmW20Tfeac9xH0pOYk4acJXgiIUqfPidBXCyf4O5KhN4pvKhy6hh7OPfFOfN8jW5
         liA7+WF4F4x3R86b+hMMrX/iz4brC4kYOW69TF59qSDlDHfdkub24wYtCS7Zlj/m9rD3
         H7ewREZof+Pg89d8byDsMG/1rZJIkzCI4+rAFRPk4gN29tRCcJ33ucv/cgkSP/upXndy
         8898Ncs/dI5d6VqAYpOsVyUmob0HW0CdZs4X1jc9EKhT3Wy02/Hh3MoJyGsi501jtqYd
         0dJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790087724; x=1790692524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:in-reply-to:mime-version:references:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gK1S9WSj9Xr3eZwZT3BugPd4DtS8wZ7bJxT3IFUTmCk=;
        b=U6tjeKWH578GfsDCBKzksKVUkacgxUB28Qgss28QTDLCKp2mmCvWTNXI388L7PHS11
         /jOETlJmvJw7jk6Xcwy3ogotlYnpvLCSFuDn0e4TtQMC9iv2UgUIJxyfCHCC/cJhp0YT
         bz2H6Pq/FB1s2rSNIS6bO6Q+rD8rt+Ed2luA7FfBGrTL2snL2OSDPfJJS5fMPj+fVTAN
         KsX2Mz95yqRB7ryUR1MgIuu5mmGFDn6uRQgaj+ijl7vWyCTSoDsJoB9QWzNwNnBeuKLB
         hNeRtb33Xlt9gf/Evajwb2MHYYPoL8Ci9H2Ngsx8PM/B+kSG4LY8L7MZQGGBGL/pIKTt
         H4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087724; x=1790692524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:in-reply-to:mime-version:references:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gK1S9WSj9Xr3eZwZT3BugPd4DtS8wZ7bJxT3IFUTmCk=;
        b=eXU1jI7XkSXUqgpaPCnAu7opYZDXNHpMWFHeeOK8grrY0BymgI/B/af5bG2hgR8Phk
         Nphl8XfCaVKzuTEBdugpZJovDKj2MN72WkHmw6eRyT4hkVPVv+9uBmlOGcCWdLB1Ieju
         Q64KU3SVfVGleto8FiEemab4wzAoEMkC0Pdsg8qMknvRY0MUVexy5fL0N14eDEuMIOJX
         VUHJYchgj/x22jcZcd1jItZW6GGOvSxaQBlT3+B699SUQ8q4T9OX5UF6t6QrYh1d/cQN
         qPnnwKrC0MRo5MAtcAhgAF9mHLk99T+kHbJTsZ7cltMwnjRHNwcJVA5ZOPb5PnXHztRr
         ty5Q==
X-Forwarded-Encrypted: i=1; AKwUvBz7p+YcbfTwVhsmqpPs1zgq+1T3YgOuA9ANAwY7m/H797kdzapXMkabQGxiGnAN1hhQsxt6sMs=@vger.kernel.org
X-Gm-Message-State: AFuF++l0Uv8gwkLnvoW1VoAloAnJPLpXpPOD9w83/SUyzLcy6betLFHW
	oteaojlAdHo2NlYrPQjzW7++70SqHR3pr/ZyVxmKxpptMdp1oBDvb6yHyAL4NSN0KkS/KRNXSY4
	3vc/ZBn3KQD459/lk5sIYRyHbHcXGhAOP7plEOwyY1OpKOa+9O4j4C+4rexgay23Qr0/XVNICD2
	rS5S/GAzgyuVg6pXIk44WmugzISfOL7TOl
X-Gm-Gg: AYBFou0B1ZnugI5LWt/3mgUwO7mXh9MqsuEuqshwZBmBP9Sj8gD06DLjs1XCrkISuji
	UaNRBeFDz60mN6gZz21fsk41iXttoNCir7lsZM1HgNvaQRM67r7nkQauJhwmyHmnTN+8BBeRzM0
	9c4R/2arGJKP+nf8q3Tf0kVI4KlHOdu22vX5ZYuePO/54fTDR8k7iDX/k=
X-Received: by 2002:a05:6102:6b0a:b0:7a8:1817:2765 with SMTP id ada2fe7eead31-7a8181728f4mr5384417137.11.1790087718406;
        Tue, 22 Sep 2026 07:35:18 -0700 (PDT)
X-Received: by 2002:a05:6102:6b0a:b0:7a8:1817:2765 with SMTP id
 ada2fe7eead31-7a8181728f4mr5383871137.11.1790087714634; Tue, 22 Sep 2026
 07:35:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 07:35:12 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 07:35:11 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
 <20260921101538.97286-9-johannes@sipsolutions.net> <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
 <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
Date: Tue, 22 Sep 2026 07:35:11 -0700
X-Gm-Features: AcwNN1XMie8kM7dwxvbQlHH_l7IaHZoq1hw6XOWcr3XDlRFXqBgXY5EO4nZl-zk
Message-ID: <CAG=2xmNURzYdR+eL8x_kW64Bo9gEe3ne88YXaKQKT+_Ya7XZFQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Johannes Berg <johannes.berg@intel.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, dev@openvswitch.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:23:55AM +0200, Ilya Maximets wrote:
> On 9/22/26 12:03 AM, Matthieu Baerts wrote:
> > Hi Johannes,
> >
> > (+Cc openvswitch devs)
> >
> > On 21/09/2026 12:06, Johannes Berg wrote:
> >> From: Johannes Berg <johannes.berg@intel.com>
> >>
> >> The __print_symbolic() could only ever print the core
> >> drop reasons, since that's the way the infrastructure
> >> works. Now that we have __print_sym() with all the
> >> advantages mentioned in that commit, convert to that
> >> and get all the drop reasons from all subsystems. As
> >> we already have a list of them, that's really easy.
> >>
> >> This is a little bit of .text (~100 bytes in my build)
> >> and saves a lot of .data (~17k).
> > Thank you for working on that! But it looks like it breaks the
> > openvswitch test:
> >
> > https://netdev-ctrl.bots.linux.dev/logview.html?f=3D%2Flogs%2Fvmksft%2F=
net%2Fresults%2F833743%2F9-openvswitch-sh%2Fstdout#L168
> >
> > Maybe the test needs to be adapted to get the same info differently?
> > (and adding CONFIG_TRACEPOINTS to the selftest config file)
> The parsing in the test will definitely need to be updated, i.e.,
> the numbers swapped with the names of the drop reasons.
>
> IIUC, this change only affects the printing and doesn't affect debugging
> tools like retis that attempt to surface the drop reasons.  But, maybe
> Adrian and Antoine (CCed) may want to have a glance as well.
>

I don't think this will affect retis in a bad way. We collect the list
of drop reasons by inspecting the BTF enums. It generally works but we
need to keep track of new subsystems enums being added so a
dynamically-generated full-list of drop reasons is interesting.

IIUC, the only way for userspace to read this list is by looking at the
event format and parse the printf line, right? Any ideas to make this
more machine-friendly?

Thanks
--
Adri=C3=A1n

