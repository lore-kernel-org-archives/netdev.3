Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE613E1CFD
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909187; cv=none; b=M1oQDqPtTrBuKfj7fVZ/PgoOsNKSrFbN3OYZ6UGZGDV+w8sUyhOcjPCm837gEtIcToDaYTnF2leK9ueXowkl77VNK34nj5DYndfIByjxj0vkR1F9p67ahiNNzknY05V/qcRkVxRQlPlUdkw2NR1cT2A7u1KR5fKKebO1uP/lL/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909187; c=relaxed/simple;
	bh=13wssujQbIyLQCFM48Stg4nMkhMgvIXI0K6eqdMmGww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMx/vZWVd+Xr0SsMdvU0JhmGeJN1G7facRmGlGtrTi7N7ogqeuYejRoySsZMsGcNeZyWtg+54gP9wbTM8+KwXrsMsFsavGq6H/MSP+cW4bGpX+q81iaKU24TuwM7vcFtq5sjdUs9y0/esOA9MRDrVtDmnmCAq4zkcb3gjH1JH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QQt9oyqT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QQt9oyqT"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66a4c6bb6ecso8949500a12.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774909176; x=1775513976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sgxFsOJvZ8sXCMbDM96Xr96StQzCVgpxG8bopM7guow=;
        b=QQt9oyqTffHyerbQlaCtxIFBXAGsIrWiLiYBUblZj7l1q/EGSxVOV7Z3cfcdBg88oV
         r4ZEdPAL81iGcrsvJppZndeMaZ8j0297YYk7z/gpEY8l8r2jWo40VhoJbR4EV4svnZcr
         FeNsgY2le9SX3as1jFGqnsQB98KSLcM5hcmxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909176; x=1775513976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgxFsOJvZ8sXCMbDM96Xr96StQzCVgpxG8bopM7guow=;
        b=b521oYe8RmtGlXNk3Y1rFUs+8Q0yduMeuhSq2UlP+3REAeOUBCZKW7R9XMg9yL0lRp
         eJNNuCrTCXgFc9FXTDe82NeOFgf8XeiGCrZ48nErIHcevC43IWHg3uok7575AXz/QTAx
         O51cNRPhBc5y1u87P6LbmVpo+127Hn0O4acY/eDXq5efPtoz259yR3ZwmaJuvA3sbfBk
         GV1sbPfqooRk+KjaFAyURnr0t2Tljij554IepiYIk8M/xO33lh7PUZD8yRfVCYbJ5uYr
         P9z0JVC8jXYbg7QjWpDpO7EraxnzeqrjP7ccrHBAqSpyj7vWH8JoXyta2MGFhfZ9lmta
         +3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGjs2Tf9nJZe9l9+nPSN3TrbwGQGkBqF5VTG6KIS6wp49K+OcXGut5x6LexGQu027xsGWR9eI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83hI564QvgEPM0PA6qEN5Xj55KUoGbIvw49dmzmplLegvErZN
	cJ3ugHUZkc47wcWuKXMViY6vlWyW3Vn+fcE74t03phiLdI6u3OThq38yMMOSdTV/sc+gTFg6nni
	Vr2nqXGA=
X-Gm-Gg: ATEYQzzvAv2Ayx1bNbeUvziSv/j5/2dkI769GaBemDrvMWMISCX7C34713WELylY38F
	W7lbBI2U7zK24vmQ23J3vKN7agc83CGcl+u4cHOGIs/sYOnkSRMADFsCQt2f1Qifu3M1jXvzbPX
	JEIVW647yiyYNf6kK+0QQNgM+y/wipWnyN2BlqnWjODS2xdK+FzpRDDz+91Se21oYh2evj73WDG
	ToWt8ZyVzHNzwWtJlImTULZMTksUDjfqtmvGE+tidSR8zPPu0ZOQl9rr6xVRbuRzwwjF/2HTHmC
	kLHmrdYuUoPRCZsVfVdfkuTw9DaOs3SftvqYOPKm7WJHSNhRAdWdfWXKSmu0ZmVvkqw+/bxidJT
	jgxwzbf1hdB7CWqUsRnQNj/ns3Yu4+gBY1TKOYggp5bz42CRC9iPLeQjWeDrajc3q5/hSvsyqKb
	FK9aSixT7Mgu9xvhdNIn9vFMYRkwfM7Z00vW7g6NEERUC6TqMNCAA1PuCtPEsiVbfmPmxUoRKg
X-Received: by 2002:a05:6402:a0c5:b0:66b:d544:e784 with SMTP id 4fb4d7f45d1cf-66bd5543151mr3499916a12.13.1774909175587;
        Mon, 30 Mar 2026 15:19:35 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b7275ff49sm2737244a12.6.2026.03.30.15.19.35
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 15:19:35 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66c05fb27e4so1888425a12.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:19:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsy3Z0APSZfOXGQlf5N3keURmeHxBzEVRjz5cVWM7FGXSVZvuYgqqNDgI3GPyHSwJVtMLyWuI=@vger.kernel.org
X-Received: by 2002:a05:6402:52c7:b0:662:ab67:a560 with SMTP id
 4fb4d7f45d1cf-66b28c526dcmr6891247a12.24.1774908864935; Mon, 30 Mar 2026
 15:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326131838.634095-1-dhowells@redhat.com> <20260326131838.634095-5-dhowells@redhat.com>
 <20260329121208.6092419d@kernel.org> <CAHk-=wiJ6gEELLviexdmSHnyjVoG7MFo8Qwhd1zxs_tCnL-=gQ@mail.gmail.com>
 <1179840.1774867765@warthog.procyon.org.uk>
In-Reply-To: <1179840.1774867765@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Mar 2026 15:14:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDKfhS5TvEfrsOgBgAvFMPfAd3wT=Um2AQb4txHq5sAQ@mail.gmail.com>
X-Gm-Features: AQROBzC8ec9XUhg2CYF5IFXZ9-klR-Uxedhu4hxXRVBKoiRq4ZlNxeqrDUpLHRg
Message-ID: <CAHk-=wjDKfhS5TvEfrsOgBgAvFMPfAd3wT=Um2AQb4txHq5sAQ@mail.gmail.com>
Subject: Re: [PATCH net v3 04/11] list: Move on_list_rcu() to list.h and add
 on_list() also
To: David Howells <dhowells@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Marc Dionne <marc.dionne@auristor.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	John Johansen <john.johansen@canonical.com>, Minas Harutyunyan <hminas@synopsys.com>, 
	Simon Horman <horms@kernel.org>, apparmor@lists.ubuntu.com, linux-usb@vger.kernel.org, 
	stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Mar 2026 at 03:49, David Howells <dhowells@redhat.com> wrote:
>
> Anyway, I'll find a different way to do this, not involving checking the prev
> pointer.  What I don't want to do is hard code "prev == LIST_POISON2" into my
> stuff.  Anything like that really needs to be in list.h.

So i think the proper model is:

(a) normal and good list users should never *use* this kind of "is
this entry on a list or not".

Dammit, you should *KNOW* that already from core logic. Not with a
flag, not with a function to ask, but from how things work. The whole
"am I on a list or not" should not be a list issue, it should be
obvious.

(b) if the code in question really doesn't know what the ^%&%^ it did,
and has lost sight of what it has done to a list entry, and really
wants some kind of "did I remove this entry already" logic, I would
encourage such uses to either re-consider, or just use the
"__list_del_clearprev()" function when removing entries.

Because I really don't want the core list handling to cater to code
that doesn't know what the hell it has done.

                Linus
