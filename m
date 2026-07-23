Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A05363C6C
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800407; cv=none; b=VFU63JXJHZFKK5gQTuWZVy9EGzu1ke0WiJYmbgwha7IOx0YNYXpa2PPRHfK1IUpHUzPjUTZD1mm9iiK4V0UcY/Wa03P8/jzDPxpzQVLNrEkBxqNju6tqZwsDtnYqdY1rvqGkNmVCo0mRhVfyRVbY6wLXtcaYVp8LUlXzFsHxHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800407; c=relaxed/simple;
	bh=Elep9dk318qiFAULsOisrCYT4T7PWapJE4dhBhmOgSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDW4x0G/dbYVVRnEXFG9MVXAaGuLSQJt/A+S/eTafGYAasNBQFL7ADJ5p7BXIvPIyXip+ZpdpRq1SyYf7NGZpBUtwCb6S8hLS+2iw3i3jwzYyME+2K9bS2QyKMPXOZNjAHFsi6cX4jIQGMLdy5TnbQE8doCpz1gHsxjy4eTPmaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvEMhv1r; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvEMhv1r"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4956242332dso4041295e9.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784800404; x=1785405204; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2UCbAtQQdcu6dcYCDB2RvhK675NVXdkkU/VK/UtSMAU=;
        b=bvEMhv1rgsTdbbgSIv0NBvEg03ZUhwX21Ecp0i50Wc3sUFaiRqK3QKco+DRoCGNpX0
         clfj3OkXxzO5a4iVVGxvDaAyCg5D+Zrb+uteOTg/Ms57LZtT0jOCx9ww/AeaMZ3F5dSL
         NgFfj6SFyrOBAnfP7uuKYMKiRht0rW6HjPOzT2WBtLdJcDm0BvFhPyTvHnZCq+8Zq0LI
         5uPkAH2FTUgEVUBDeLsn1W/zz2caHrxr/KVeQJ7OB1K/qtYZLpEqYCUP2086oSocUHJy
         Tj5/0eqiBka5MwrsPbHCpswpm8jFbP0a3B+kxxAOOWjrKfrQHUHGbTy+iUfL+jxr1fB2
         C3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800404; x=1785405204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2UCbAtQQdcu6dcYCDB2RvhK675NVXdkkU/VK/UtSMAU=;
        b=BMDTStNih85VuLu09MQgdkw3FFCcJreNB/rU0dnns1jJi3cdQDX9cwd+NxYEOb6kOF
         yRQs9wVTuo47vUEr9xX/kX2shQ2PN3vECbygIGom4JUcdy0uGV4VNzJdAkqyEYjN8uIq
         tVvyuIJm6C8j4s9GwvR09mMYiCyu95G86oXA7u+soP9Lkws2d7B8ZJ3r8bR4nGQtx5zD
         dnloJ82GkgE3caATaiNV++xHCCFRW5M5SWP1eSvzIFEChiVjJKGqcrsKPoPBrPH3xKfh
         b3L5t423lNXbxSyHVilKsUwXdI7G63lTEas2MgK87yeOAl7sWKbOMDb7LGnWz1Zlybnr
         jjbg==
X-Forwarded-Encrypted: i=1; AHgh+RpRHmFxaX1z7nhgjzjcCbqi8P0+EgAhRxSWOjA1O0xxxdCE2ONG39TIVoUvcpTagEB/sCYe+LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwargeiYRsdoXs9Pv8f8w7CFgqobaNNM03gwCtiEDcfvVDiI66
	tP3qqXhA0ZAqhF13tPaLlN3u/mBcYTBR/4+Stcuzpkg8CT98Lr27Nw8yFb2935dSpQ==
X-Gm-Gg: AR+sD11QLY02EWIT6s4Hlc7iNkor6hHffggmhcrIQcJxkG5pKY/I/JmaMUKjCBTedJd
	rIINStSJXqoSK1/WKQwKqyDxkQBsPimmTQjTw0zjpnS+u0SKuxCZkPKIaT198EGr1kceqQ3uql7
	E6aNpSLcJwdZGjbUj37PJDcZn7C5DB8yrSWS1B18wYOhXNr0zrMWgoRSVr14ivM1BTUf8nmYTIm
	KpW01aoRMUiL94jbyycQ0dls/uDZilTarmx1oMMn/kTHffkpGk8hFKOIZdB/fvnWhu5Xee2fU/8
	b2iE0SxXSAEi+AwGAnw9ErMf/lrdR8HjXq+kA2WWmnCZcSHGWefLl8XbB5HLvmcWvamtVup7C6f
	Xz7BpTbod7fuhxyAYD4XL+fxndPLLr4HnSgupMhli2mhTyKS5wNLZWRcfsraSBxGHIDQB5ycIgt
	zKP2uVGbb75qVKSv+0ngVKZtKUoKgRvxY1
X-Received: by 2002:a05:600c:1f92:b0:495:4fd5:570 with SMTP id 5b1f17b1804b1-49573cbe8b5mr24908135e9.4.1784800403454;
        Thu, 23 Jul 2026 02:53:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:a914:97a6:4219:66dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956ab45df3sm99358965e9.1.2026.07.23.02.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:53:22 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:53:17 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: John Ericson <mail@johnericson.me>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Cong Wang <cwang@multikernel.io>, Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Andy Lutomirski <luto@kernel.org>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	network dev <netdev@vger.kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: unix_stream_connect and socket address resolution
Message-ID: <amHkjcsSM80Hly1I@google.com>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
 <20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
 <e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
 <20260718215855.07284fb1@pumpkin>
 <85991dc3-6fa5-4466-a0cb-b407291cdb44@app.fastmail.com>
 <9c437c7c-7919-41e2-9161-fc94803a9b34@app.fastmail.com>
 <20260722.bfca37efd700@gnoack.org>
 <e4adebd8-181a-47b7-b82b-b6d9baa6b203@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4adebd8-181a-47b7-b82b-b6d9baa6b203@app.fastmail.com>

On Wed, Jul 22, 2026 at 12:02:24PM -0400, John Ericson wrote:
> Thanks Günther!
> 
> This example makes sense to me. The behavior still feels a little odd to
> me, but I can understand the practical benefit of what you describe, and
> also why changing it would definitely cause breakage.
> 
> I have one addendum to ask then which is: what if before the loop we
> pre-resolve the parent directory as a concrete `struct path`, and then
> on each iteration of the loop resolve only the final path component to
> the socket itself? (That is a single-component lookup relative to the
> pre-resolved parent, to be clear.)

I am not sure about that.  I think the difficult question here are the
ordering guarantees on file system operations:

The file system can be in a different state in the first and the second
half of the path walk, and I'm not sure whether that wouldn't violate
file system ordering guarantees.  If you intend to send such a patch,
I'd recommend to loop in some file system experts (e.g. Christian
Brauner).

What is the underlying problem that such a patch would solve though?
Do you think that the performance on retry is such a concern?
(After all, you'd also have to do a "split" lookup in the happy case,
and it sounds likely that that the retry improvement does not amortize
the happy path penalty?)

(This would have to be explained in the commit message as well, per [1])

[1] https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

> Per your example, a legitimate server restart recreates the socket inode
> in the same directory, so this still picks up the new socket and
> reconnects, while avoiding the effect where a concurrent
> ancestor-directory rename causes a wildly different socket to be
> resolved. Hopefully this preserves the intended use-case.
> 
> Note that this does mean recreating the parent directory itself at the
> same path would no longer be followed, and a rename/unlink of the pinned
> parent would cause the lookup to fail rather than resolve elsewhere.
> That seems like the intended, safer direction to me, but flagging it as
> a deliberate semantic change rather than an accident.
> 
> If this sounds like an acceptable middle-ground to everyone, I'd be happy to implement it.

—Günther
