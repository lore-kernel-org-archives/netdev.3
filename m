Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CBF221F26
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993306; cv=pass; b=JRAmobEypkqNm7v/T3yGDEcjxrfBhviRHfSz6eP/aZ/gBGYRAiVTjMTYL472ScqkzpjDMCf0ukHNCrjTYYDE8B0Vg1n9oWFG96ylpjOrs2BCn8/oj1HSA/t1OxVpEGuIj2UYJEFsw+NgMlWGLB8z9VQs8o+n9HWlWW/grmK0xYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993306; c=relaxed/simple;
	bh=GMMtnepcEBtS4iARNnXuVa/HZhsIVsO8ZjewDzkeTI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nX7G/PEXROYveJXyIPu3owbTBgoFI+KYoHkG1anRCB8PSJgRkojXz6azijmJeaUatkk4r7uNd0gbTkuBXt5TnVLz+uGd1CIbZh93C9qFo4AbrNodcR+cawRc2fdQH1v4Qag5sqn04f9Lx33IOjrhV8NMEQXx9D6JAsUpmC+T594=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axFTBiw7; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axFTBiw7"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-794911acb04so11531067b3.0
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 06:35:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770993304; cv=none;
        d=google.com; s=arc-20240605;
        b=kqsUtJES0Rj/gJN+97u1dOKHMUFU9lvgefutomx9h1DP5C46aGkBUMnoCOsqfcJ6+k
         piciO1MJ1hLh/107YD9qNC+sI8fb0+YKmwPjAU8zmdaqHliDXZTwoKeHa+86TmzT627Q
         XvRzT2DFDl7waRNfCukMB75ZKE44/Ng6lJ5EF7m/UUetaLnKux+tLGab6GTp2AW1ioT+
         eNcqaHoWEVeLO+bsJKxtN/jBZ4IW74OLUKUo+tbnDrxBVW17VduHBAWj6+XTIRXENcDZ
         LMHq6UCQsS/4tmoiEAqWql0rMfmdR7n54PnyxGQyKz/Baf/Txj7J+o8CgJHQVPhARm/j
         WPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GMMtnepcEBtS4iARNnXuVa/HZhsIVsO8ZjewDzkeTI8=;
        fh=WutOpc3O40ZSn4ibX3wuHyEl+Qoe2GTT+mfxF/2qbEs=;
        b=VR+gNp1vJZmxKd6N6eVUZnC1fvMqd79rptK2SbCMV8RlTXosBs90Ke9IiWZabM4ixK
         qbH01cLzX4IPXorgCNwAC7YFwc3st9WFWvEWJ7DPpdjh4y4TouJ1ZwtCQ0vmYRTVz1js
         pm4y0o1P9oDaiffas7EOP0I+ZvamJCtj3luVFzCMVovKLL/oducSpYDe1oR4GoCsj/fu
         o5PPO2y4F2xgcHjU4V0kqzNbibpe6CvPqQ+WGhKeOYqkUmGKFcr9rgto3RCQtspwv+Um
         DdP3B/cCzhm04fPfdu+V40srKul+10hkrUrAzE1qn+OLizwRACcU53lFj8zuD/+yKjC6
         eU3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770993304; x=1771598104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMMtnepcEBtS4iARNnXuVa/HZhsIVsO8ZjewDzkeTI8=;
        b=axFTBiw7z2g5cu9kMmK/R4zF3yd0uDMcBd9b9VpO4gmWZDSU+isjnlx3EzRrcD7qwq
         oEG8DQl2OqIGaCRjW6k96YUh+9c0hSXeFp89BhwZA2oko6EmwwJnHnNjsWFNrxHKesqn
         F0nCw488NsuZ/ZCmIIjFhac66mkRqAR/RTH9NAjeFYOwOq115cGoYz8ZOuIBMmNY2z0v
         y6T5RBUfF3sJTnwmYzwDV1P5RVYO+zeJar128fzXPBBXTfT4UCj74UEwMmHThpyusZ1y
         czHstEZ6uaz9ujMMtocg8WuMZXpcniqJJXSYJBdZoj9oS2BRiRht79mcgua2b2HNJHHR
         sb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770993304; x=1771598104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GMMtnepcEBtS4iARNnXuVa/HZhsIVsO8ZjewDzkeTI8=;
        b=kzus58sYK+CnWh4hKGKzb8emyCtQ6RTvznHV2B7LRdfBnY1LMJWYYds96COxwdC2+x
         KU+p9Z9vQr1EPz8Wv1kbkaesbFTJoiKpHafmQms8bglsX9zixKh8SyWd8BXjJNSTypkP
         kti6aFMpKGkiPA8W/QDAkUt4vQ63sQ7I96eg2VSY4hcFi3IFBD5YT6UUv7t977zHZa0G
         y8udKYHf68gbZacql0UrEcZsdmAohDSe+qXkyAeaec7VwRB1ngk3Pq3Ny93+9gQTXuH4
         JA+SCdxuZ5j6qeBFICo++ofTVG9l5ctulQtupru+0V2B2GFt7NTbQjLPdexLGb1kmrMz
         OZYA==
X-Forwarded-Encrypted: i=1; AJvYcCVS/FAhv2NiqiMBHf6VLUPh3o05yFy37/fZBSkyZ2m0ejX5BHQ755ydPYx1KGoU+wNvw/fLk1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSr4RzDFuHxV7hkQ4v52jjrDBFmqR9SEay5bynUZ+xP6TCnnU
	ADSNafSVdBWYM3Pwmz7dDAXQmRueqfNk0bsIPAF0WAXul9xEopGcLw5YVuCExMzRMl6KJGrK0j+
	Q1hNZcx9EGj2r3tL4QR4xPrUywL4Y0qZSoS/AK67b
X-Gm-Gg: AZuq6aJ/Vn5imfA3ncZgyY+GRuxTbwXQCGBpd01c8d+72KevYfSttp47Y3dP/nj9LSo
	T0jCSIe4zcPvlqf3C2QCgbaqWsuVWZ9mHhBy9ThA2ENXHEr1uFFNhY5j7TFxGDLnr82NLcB6L7p
	yZtwTau+Qv3M/ENtKiFzP+f6/VktIgzXDrp8VkBs+Wg8CNoEHYJdBqoehnjjMuYOsCMWTeonyJa
	C+D+PBg6JzwAaDXnZ8NLsXweb+05Dzx/0bmfy4LeRK8c3Gd3039No2CwgA0M9/O8kyYOBbM87mK
	qVqfODc=
X-Received: by 2002:a05:690c:e361:b0:794:7e1e:7f8d with SMTP id
 00721157ae682-797a0bf2b85mr14755907b3.18.1770993303437; Fri, 13 Feb 2026
 06:35:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211202003.4550-1-fmancera@suse.de> <aY8uYmy1adhPqqbm@horms.kernel.org>
In-Reply-To: <aY8uYmy1adhPqqbm@horms.kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Feb 2026 15:34:52 +0100
X-Gm-Features: AZwV_QiCoZWgimzV9KxMe1G1QFSmVcjPfXsBCI85cd9hM0ggpWpucSkyxWxcbA0
Message-ID: <CANn89iL4zCq6gXNj7Yc_gXOrvtUhN+Zcdw5pbrUqZDgYez0ujw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: addrconf: reduce default temp_valid_lft to 2 days
To: Simon Horman <horms@kernel.org>, Fernando Gont <fgont@si6networks.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 3:00=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Feb 11, 2026 at 09:20:03PM +0100, Fernando Fernandez Mancera wrot=
e:
> > This is a recommendation from RFC 8981 and it was intended to be change=
d
> > by commit 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
> > but it only changed the sysctl documentation.
> >
> > Fixes: 969c54646af0 ("ipv6: Implement draft-ietf-6man-rfc4941bis")
> > Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>
> Reviewed-by: Simon Horman <horms@kernel.org>


I would recommend adding a comment, because final RFC states
"TEMP_VALID_LIFETIME -- Default value: 1 week. Users should be able
to override the default value.

https://datatracker.ietf.org/doc/html/rfc4941#section-5

So... do we still need a different value in linux, and why ?
