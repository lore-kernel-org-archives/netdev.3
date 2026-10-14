Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915EC480DED
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013060; cv=pass; b=IOaIc6w2+oUxiydDtS7TMJkopkGrWTFAPLyQc6OdUqpkAQ5urKtLagYw/CT96Ae5pxIlDYt7H9N5rfY3P/fkPScyD+FMXAtt23HEOWS68iHgrtcR+a8xpHRjUAxXV2/+09MAZswNWuLBQ2yo2Zfgo4pc0oioPD6n749gylGR+r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013060; c=relaxed/simple;
	bh=r63gPEMvPL46RQn5CZ3hAGQZunKTStReh88mSxqbHk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kt739XumrC8ckbeqD5oqGmxWYKpjJSQmswhkP3UlonG2saGmMz9Mv8vRn5lO5S2IdaHnZMJYZITSFgJkX43TtD5t0Cb3wuNoZHDdhzNWwVujbaQphvh6IyUposzuxlC95I5Rh31wZnvlNYNAH99bY4CMFNhYn/174e3sq+G0mTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=OWdpkyxE; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="OWdpkyxE"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66fca0709caso901822d50.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792013056; cv=none;
        d=google.com; s=arc-20260327;
        b=FWnPh/U90HxtWEmYqUgCu0m2eQQjs9hXS01XTfJuZFC/8WjI9kqsb9STeX+8HZ/fpn
         r6l//ruNSj54xihwMbEje3tB6h9I+aM0qW5jt80wDEVXEyzbwmFR/15yLLxWNrS/Z3Mu
         szKbuwM8lbcrJCDDTJicvo4tRbdZlTbtkHtAvBfhX8NekJOB0poVY3pvTRFRa5d+IWZq
         T/OYB7jaBXY6EMemojLnRyEnz31vSe1L5XQHqP0vex9XH7lBorcIl1SCT2/fot24OKPT
         ohJn4mmp/B/l6wkPWsjRnu33uDD7loWwymPFG6fRYVoSNhR82W7+GKc7kuzPMsFG+CX+
         Lqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2r+3eSWI2QRQlHxhWBBPMAcUqGg26+JgtcOo3f8da98=;
        fh=R3S79IzlyYtuEJ6VoR3r0i9Yh75xL1jDqgtLBbfZ7MU=;
        b=PJDqAAbWw0BNYxQfx1jEDgVQkLkF12PrpiTTKLF2xDOu5WxChlfI3clzOAPB2ZvN0s
         F3po6ECVgXrQsE4tXZeohrEqcFCMsjOnpKp2KewcVQlZqcSzWoA/ACcP8hhR7vHT9fmP
         EJuNNq3/9zFlkXnQsEXXGT8LXqJGJRQM/EnPRpEW4lvqFdntq9VGLwgDkAZjYs9zLhrY
         bWFaK1jsPehmnGOOhIUcZpEWyv5I6J2FngO6rAbG0WOHXhfuR7MXA4pG93PwSbFgCtv2
         smha0ySdIdYN1XF5JXAKrubWb0Jwv6+ZzjFze8XGoCUCTni8TQMpXyobVvH1wgGLXFeL
         cCJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792013056; x=1792617856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2r+3eSWI2QRQlHxhWBBPMAcUqGg26+JgtcOo3f8da98=;
        b=OWdpkyxEJ5TnzcjENDcaA+a7fHg35oYRafNUrZqSlKGyEEAngECYDjQOTtuf923wJI
         uXITMvx3ZKGLV9MB06KrFKv6lglH9cRt4rd1U/ajJRCL5CCq9VJ399wc7jml892IunRH
         otivvuTloqHrLmKPDITwXC7mnD9NG6kl0RBPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792013056; x=1792617856;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2r+3eSWI2QRQlHxhWBBPMAcUqGg26+JgtcOo3f8da98=;
        b=EOO7UQRIX5VxwK2FmcxERtVl6GOhagRA41ltexu58HZVTOLkEQLVndYEirszA9TqMi
         KJ/Zbq8vLlKL7tmSLDWPlrazDO6LjGEThYAY/YXyjmY4N1gLggP0uN2mIJMMtKh10SkP
         b7wL+Y0Aj+KA8yXvRDi9gKgG+KcZ2UzXzwUKJfV/oCXiMEO5+2rxSNmQ2XKC28MSHk6/
         h2n38LUQ2i6zJgtE2uZNWY9dNj253eAHq2gQe0qTM9fqXqUF0+sbZ6xWgHApOvclnPrF
         vCZw02VjQ9HqYRryWqFCAoTgVEIs3teYAxMZex9cx6pQv7iTV9DqXAdXe4nxLdFIlO58
         xd7A==
X-Gm-Message-State: AFq9FYJm7Skf0bH0fOuSFVJGXYvF6//2Lgnb/Wa6hWR6JmSTFq0fyIC7
	IiVjwUCcZAts1m0B1kAW/c5CXgLX2rimRnXjE5J0n8VT5cmgp6yO7jil4PDMURG7FzRJm2Z7GzS
	AMvmt1ZJt02sNmlg+lFLSLSgyAcJqOf9fWRmkMeHB
X-Gm-Gg: AYBFou2i5zeK/IuJMwlxzHVK9puvYag7wt73aKAYEJNE1NVWSuRHAgvy+B/PT1K+/bu
	6A7rzHtP1dOluO81gZ8IvvoN9/AxmlF0WjnCXt+bXQygyQlyzoCRqADhCUC2vEeKsGTAqqu93UW
	go6eutkRSakybcryMujrJCAuagkiCtIdiij2wOMs/jZcdK17tcU6D305eM2RrsytuFvNoqSdyJs
	HYwG2x/zwdlvO7YKHFvkCJeKWN32g+PqWCAIv5FXMkU0Jh+zeciysdOPRldvvrjqEond4e8idln
	I2hjAGHrx9b5pEuJzHzv4pfHvBhK5Et0g6PHEEDQjBM4osqxJKz1hRGIH7gfEYTTi0OCXg==
X-Received: by 2002:a05:690e:d43:b0:675:3f33:b183 with SMTP id
 956f58d0204a3-679362745a0mr6171135d50.24.1792013056258; Wed, 14 Oct 2026
 14:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014121414.2373985-1-ivecera@redhat.com>
In-Reply-To: <20261014121414.2373985-1-ivecera@redhat.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 14 Oct 2026 18:24:05 -0300
X-Gm-Features: AclHuK_VTAdZZkQW0BtcsHxlVRXv9pULtYyY-Xyg2W4k_wvNoU0bv1qIgpz4UTg
Message-ID: <CA+NMeC_dh5k-WQ52q8JOqYW46=dzT5EKnwuc=kLs7Mr4g25ZuA@mail.gmail.com>
Subject: Re: [PATCH net] selftests: tc-testing: use $IP in hfsc test 8c39 setup
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:14=E2=80=AFAM Ivan Vecera <ivecera@redhat.com> wr=
ote:
>
> Test 8c39 brings up lo with a bare "ip" command. nsPlugin runs it as
> "$IP netns exec <ns> ip ...", and as tdc runs commands with an empty
> environment, "ip netns exec" searches only the default execvp() path
> (/bin:/usr/bin). On systems that install ip only in /sbin, like Fedora,
> the setup fails:
>
>   # ./tdc.py -e 8c39
>   Test 8c39: HFSC classify walk still reaches leaf after lateral drift
>   -----> prepare stage *** Could not execute: "ip link set lo up"
>   -----> prepare stage *** Error message: "exec of "ip" failed: No such f=
ile or directory
>
> Use $IP like all other tdc tests do.
>
> Fixes: 1e24c4f2ee44 ("selftests: tc-testing: add a lateral-drift hfsc cla=
ssify-walk test")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
