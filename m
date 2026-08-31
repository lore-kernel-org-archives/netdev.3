Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034923B8406
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215225; cv=none; b=OwqaJqpfCazvnPldWBOQ8S0jxfHFytReaU/1E5hsmtjtzPvCaQ85JfoGQrdnvRURwksOoZV6yEfIYVJ2y1/ireW78y45kQahWJhhJUluqFTmK/di5Jf9vE+HA5klRfvhPqxgo/ID+6ClCs+RLVscp5ePWq0GBuw3yLOiY7/dO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215225; c=relaxed/simple;
	bh=ObpDhIDtaPFmVq1A0Tfct/Zf70yCF46d39cW7lRwX6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZfWwA6Y9IiRiryJNDCSxsrckcj/Abbt7FOcOvTu5+RcVNVIk+BnQxU+TtmI3RUjYybCcpvIEgKwWAJ5H3Zbq7ZB8Kib2NN88enXa/hSgbE2VLTfWXKr0h1QzougcrmnclBjBj+/2MsTL91aa8V3pR6KK+J9+/EVxAj6j85KrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0nnaIXB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0nnaIXB"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cede6375caso44895ad.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788215223; x=1788820023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IRt+Et4enRDJl2yrF6XadJrav4xwHstUxCtXFADfmWk=;
        b=r0nnaIXBLQg3HouHh9xNno2uiHdoG2++IAooMXfecW+tUGiKo0dIzNE058KIdFM1Va
         l6nMM2Cq5QI3QgR08ec6VZbQHQwtpueYAxaMFwxbkeOc60pEEEDFyjrxUq1+Xtf79ZYU
         l33hdPXv0eATP8QCCUCelnOvuOUKBqA01zLPT8Zaex0ome/47m53UP6rMjLWPq1IpEPK
         qYRh67muhk9yIna1AEV6lEZkEH8LjGhZTADAZ4MtzNF7Jv/X8ffKdo1OKJYRLlX+yT8J
         OWFW16AMN7+lBBOIHNLUrLhHRDprZ9rp3RX3VSbnhjGp5THX4OZFJ5zoDoBZqnJwbL1g
         XTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788215223; x=1788820023;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRt+Et4enRDJl2yrF6XadJrav4xwHstUxCtXFADfmWk=;
        b=X0+Fuoz2Y81JYHXk023RK04jasbDBZtngoAxlBU1/a5WTIEPhFb3Ewiggn2BGp0VR5
         4Tan06IJYydfTsRzb7ofcdyXdcXdYyleQPrnG1ArVqk7nVm5k8E649iGhstvLyxNL1GR
         dAoexFGjZNIv/YB+q+9gEYMConmCoMwC+nGVMr+gsC3mzpbYDj54xEFBEiqUiWUagWSX
         n0ygl9puLTvRpF6Lxhl4Rn5/wCWxtvUoFth9aenuoeYF/h/FmAJbjLbAvnVwEJh/+79W
         NJaigOHss/BSMEXUnBRUNIuCfdZFlMQgHCJJoQy+MHRc7GXlAvtfM49B17e92bs/PYTz
         /T/w==
X-Forwarded-Encrypted: i=1; AKwUvByu/urXQnblc0GHDpCnP3aWsBI9JvbHqbnjd+iUwZZMP0wGZH1C2DjXPpvR69qXO/8SJDm94aE=@vger.kernel.org
X-Gm-Message-State: AFuF++l2hMr6/XFK3KD0H/PbjwWU0BCU/NLo5PBp12M6QXoNr3sOffWc
	B5VlD9MaczehDlw3dFhL0a4b2gCdJlbrsnBI2bJnccWivaoeqnI+tcZT7BklI2Jr2Q==
X-Gm-Gg: AYBFou2avAhmmIM8/E/Zq5B4gGXy+v/Hm2ukZA7XPFhBDs0r6FwnIO+9QNikizJZWfB
	XfWxn6wG2LJ80RHsBpVw5bTW47qeJjoRC8M8ZSE2v40CoUPLAS60u4ZOljT1ghDGMTrgMdO0bap
	d7nphFY/qnTCQxe3DU0eWkbtuGQUWcaSpzJQ09kI4rGLf6rJJl9FIR/S6fbVCDLVIiDch5FugtV
	xCm64RuAoQZGkGOQTL2Q1TkMSvS4fehI5zMmfDQmv8fg2i5NaC660CYQ9Ic1+RAK6fROUpOUvOU
	n8BtWMzO8VM9XpxAkX0KVvNsaBndX0v9U8tvBL7cVNr5z4f4wkB0Abxx3oOvaqkaLVaIZIsCWsZ
	L+Pkhm04pPTteD7FEmYH/JK005ybuSjubhNdJzAwObtRZCwG6GXAe47vodF+q/V9G/NpG3MH0aS
	SBDFiG18wlnpZrwFxmOI+/48LuZWKHT5Ong0kkTwy5x+h2H5aH85UF5y/2scXzoDE5LzAsPHpeA
	CgVwUCgnDUSOCzG6gwjoHtczDaHBrx525Gv5ietLvvqtaE+GvViDEyaeiLXwJWpPhdJTG7ZZQib
	vkhz0r0=
X-Received: by 2002:a17:903:174e:b0:2d5:db3d:1a43 with SMTP id d9443c01a7336-2d95213ffffmr2991545ad.16.1788215222431;
        Mon, 31 Aug 2026 15:27:02 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d7759bd1sm5651120a91.3.2026.08.31.15.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 15:27:01 -0700 (PDT)
Date: Mon, 31 Aug 2026 22:26:55 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>, dave.hansen@linux.intel.com,
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com,
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org,
	jannh@google.com, arve@android.com, christian@brauner.io,
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 0/5] mm: Unconditional per-VMA locks and cleanups
Message-ID: <apX_r59k4e-XiI-C@google.com>
References: <20260813193433.3318288-1-surenb@google.com>
 <20260829185625.f5ee1b2931818843a78af88d@linux-foundation.org>
 <apVhzM2501wSiGGg@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apVhzM2501wSiGGg@google.com>

On Mon, Aug 31, 2026 at 11:13:16AM +0000, Alice Ryhl wrote:
> On Sat, Aug 29, 2026 at 06:56:25PM -0700, Andrew Morton wrote:
> > On Thu, 13 Aug 2026 12:34:28 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> > 
> > > v2 version of this patchset [1] was written by Dave Hansen and per his
> > > request, I'm taking over this series.
> > > 
> > > tl;dr: Make per-VMA locks available in all configs. Simplify some
> > > of the per-VMA lock users now that they can rely on them being
> > > always available.
> > 
> > It's been 2+ weeks so perhaps a refresh-and-remind would be helpful.
> > 
> > But it applies well enough and is adequately reviewed so I put it in
> > there for testing, thanks.
> > 
> > AI review might have found a couple of pre-existing binder bugs:
> > 
> > 	https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb@google.com
> > 
> > and a small rusty thing which you might wish to attend to.
> 
> The binder bug is not actually a bug. When using VM_MIXEDMAP and
> vm_insert_page(), the vma takes a refcount on the page, so there is no
> use-after-free even if free_page() is invoked without removing it from
> the vma.

Exactly! I agree the refcount on the page would prevent the UAF.

However, we should still reject mremap() because this leaves the page in
limbo since it is not given back to the shrinker and also binder can't
make use of it anymore. I'll send out a patch to fix this.

Thanks,
--
Carlos Llamas
