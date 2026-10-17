Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A1377A92
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254957; cv=pass; b=RGqmsgDqHlojmx/WO1CMQs4EY4j4KkQ2z6RMTEZzSORCX0qYysI5SxV/ja9Ofl85uHscpLELEo+ZhdBkRbC02WZ+4g6QXlIfKlQqmK896pWaM6B/KXFX7MMyNXCKUdqP2qKBR7Abdq37DdfXRUkYwsewaA2kxBUHAQ5dGxKmBD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254957; c=relaxed/simple;
	bh=K575d+X/T8zxf8IPb1Vxi4/BMBu6K4J9uKB9yZoQ32A=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzDRzWTZgla2OEYNic0FuegVqcrMs1APFcqa8PNw7tEkyOF9zNb1TJ9NORsHsO1oTQyYfBU1xnWEppmS2bH2Ui5qCtlhTQxu1PwebACSVSPSiPHg5YT/3XwzvI2pYHWJBzK28crw+BnKYJkAF3nFhUfOwWsr3QywcCU3Bq5y9sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0KGGKWV; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0KGGKWV"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-535179e995bso10314421cf.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792254955; cv=none;
        d=google.com; s=arc-20260327;
        b=R/hEGzRnGceoeA4CUjjQkPnwF2kloRtrsaYFeTANQ29kxALmJ6ISEsFuBwDgpE/AWC
         1VnvuOAvtoxYVwBGICYiuPh61VB3V/cohI8Y6bUr0yJHEGDODF1UqyCEQZCOsfHBmUuy
         v9xrdsQp3OADPUPhP7LoJtBBDs4XXN67zWjoS7SgzeWYU6MAYIrSP06qvAGI7E+HuGYZ
         fSqbBmNP4kBoAqt2FWKpR45LpPdtjOxsWEISOPejaFHpWxUEHfgK0dZdn7HrGDcTQDRE
         mDqzy7Q5Hjr36i7t4821k9+B+EmqSOx4DCxM7a7BD0sw+FGiK39DO6XbTEvvDVlo5CTt
         DqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=K575d+X/T8zxf8IPb1Vxi4/BMBu6K4J9uKB9yZoQ32A=;
        fh=j6hS4oky+3zPK1QZzfFI/wFYw4W+iwqjrtarZFPO59c=;
        b=SaUJw+2U5nmtZdJJ3hMM+Sn3VcSetTE43dKUxt+01OmSi7wcie7r6NQuXJHdhgTkXB
         HGwibhhMzReH9toF17VgXIYrcX0m6eLWurpk72lq8zKylDajZV4QB13Xw28FjS9AmMg5
         uDj/a603OYYE1JV08s5IEET0oD300c9icmG9AUdMMJ+tRYxGssYgR6EkLEKMOUa0AiXo
         IU8m1WXoj6u7xHgju0qvhx7tUJEnVE7zmvwV3x/riGX4Cp5yBa1WHlq6tGUpYBxLU4nY
         UiAGCBhKIhAXdGe4G7cMIRBbTqXx3ItDmYUffNwiOj4CR1w/3iVzimJR4A6T9m45YPnm
         GW0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792254955; x=1792859755; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K575d+X/T8zxf8IPb1Vxi4/BMBu6K4J9uKB9yZoQ32A=;
        b=P0KGGKWVcEkW4KG9ENXfXln/1TL0YjJPQuXbApexWo6H9NStRdr1hOEfHo50t5S1+T
         tzWfqQup2e2Gccu7ziPyIpNPRLt7MkZZHC0CRLC8+PfxP5OstguomdIxQbQhGKYzocZt
         2wbAqdmztclQihFvYP8zN9PYwDGB1YRH1hobn7p/21X2/1nZZ9xT1zHcRMd5K5Zw85Sn
         CcrpmuFZ5T5netF6CTw3k/baCOBHj1ipzo8GAUnrpURrX2+PYC66dKgz6e1OHCtBCXh9
         TXyuR7RuFvcVOdjNJ/U3WuEbXwRnA355Q0/7FIKQJA/eNiuHKu65lEvdOPiIv636FOSs
         yXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792254955; x=1792859755;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K575d+X/T8zxf8IPb1Vxi4/BMBu6K4J9uKB9yZoQ32A=;
        b=P52Yxq+6wwtNF/7U5kJlDDasfIKfyKvnJA4Oq0nN7dO3NRPw5KlOHlzFAoNzjTXkfk
         hwIWKTC94d481xKr88FeoBsnSQLdawuZ4UP089UegW9fE/fDnYtT7tBPuivCV3rpoYBc
         3eoRWccaDVKEihQKBwYnboAc3b9bECTkrO+8jTtwWqCLXgP/gH0v9WQBfsJzcd39CldK
         qKo+PgSHdl7TF6I+UdK/2sfh+s2lmoonYSe00bLmInWjwNBxhoXWgGNgT73DAAvvfAct
         D3f++LBkXyzp8cXVdyDVM1EJ0ToZY5ASxo+mIy9uU1ybAZsl6YeJMRnldsYK04oTGkvF
         lyyQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9PH6uZQ8mLXUb8svnqyCKUbAMaOpIn87bTnn7ZsEG8ODjbMEoY7szq1/WfPUN98tyvVvYC0o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsLI9a8e8ckj17tWdheVD0vval2ZQzbJONkMNYQ7nxJeiAmHbi
	SDZ9RTrrVT6KEDzYPq4j+CwvXFbQb6W6jxjppyGqbDOHYKZN2rWO3OeEx0Tlo9wsiWFhhCPU8Iz
	Fo8teJrTxK0hgePqmd61ZcKhTC3WyJYE=
X-Gm-Gg: AYBFou3qKa5+FKLGatdThZMI8xdv1+EIFwrM7Xd3clx712zT5kHW34Ejdn5tFN5hu9L
	FAsSXRWpThvGLAEvCAgEY741yzmdlXN9/eGcmefE46zOHd1dS31cd1IPXHlipBeidn0NQ9ciCpU
	UbW618aTWDYmzC8IqeJxVx5v7u1WAxYirBsqsNIyTyWezPrTur/96Tob+MbApunYXpIEpxTV1ro
	C1HZhThE9QMxWbNb46wyJiaYQFN4v5Gzx2OSAaJww04cDalCbzcCRkG8Fe9FRqp63d2r0/cDLyL
	b9o1k50jEHq6bip+mRhJskLHZxfkWBbwHCDTcg2kAnli+ccmgmRaHAkGu1+DwA0t61TWNbLE3fz
	IGsxb2E1JuLu6UIEdRK6lxj2aRMm9LHXJElPqhXeD2kEDBijfEi1impDt55Kln6Q2vC1fKk00zR
	V3Jqr+dwS1wtUW6hJg6rRDc6lhC8Sd+HAUylW4R9Sgg7IACzMZbOMkzgDjykGnhKG4KYteucMuJ
	m2IWLqJRbQEX4LkwgJcM2n6
X-Received: by 2002:a05:622a:1244:b0:536:4482:2c5d with SMTP id
 d75a77b69052e-53645e074dfmr47949901cf.19.1792254954694; Sat, 17 Oct 2026
 09:35:54 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 17 Oct 2026 11:35:54 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 17 Oct 2026 11:35:54 -0500
In-Reply-To: <willemdebruijn.kernel.eb0f6ff37e8f@gmail.com>
References: <CAJPVW+=XcHDV4aoXt5oAHYh49kX7m5wUxf7TucrcBy+q6MdXFA@mail.gmail.com>
 <CAJPVW+nstfbagm9GxQ=i-5J6Xi_aZ52-YiQZeYrzmPD3OmDNiw@mail.gmail.com> <willemdebruijn.kernel.eb0f6ff37e8f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Megane Hebo <hebomegane@gmail.com>
Date: Sat, 17 Oct 2026 11:35:54 -0500
X-Gm-Features: AclHuK-g419mItqEZ0pdzSa8CH0A7yGLpafb0QAT-ug0oTfrYzft6MBGpXjOWuA
Message-ID: <CAJPVW+mYavbi3q8eacV4=V8Be0-_5RV8MnksXPhiEvin8XfGrg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] selftests: net: exercise virtio checksum
 ingress outcomes
To: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	mst@redhat.com, virtualization@lists.linux.dev, habte.yibelo@gmail.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Thanks, understood.

I was optimizing for preserving the semantic contract, but I
underweighted the permanent upstream maintenance cost. I'll keep these
cases local unless a future regression shows they earn their place
upstream.

I'll use git send-email next time.

On Sat, 17 Oct 2026 11:55:26 -0400, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> Megane Hebo wrote:
> > Correction: Gmail Web rewrote tabs and wrapped some long lines in the
> > inline diff I just sent, so that copy is not suitable for applying.
> >
> > The attached format-patch file is the authoritative byte-exact patch.
> > Sorry for the transport noise.
> >
> > SHA256: cd11c3970f0a23ac039cdfcdc6338c20c79dbff3db8fdc93ea53b4b8996437b8
>
> This is not the way to send patches
>
> https://docs.kernel.org/process/submitting-patches.html
>
> More in-depth: with AI it is easy to generate testcases. We now have
> to consider which ones are important enough to submit. I think we all
> have reproducers for these specific fixes offline. If we had thought
> it worthwhile they would have been included in the feature series
> itself.
