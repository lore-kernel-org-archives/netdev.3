Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038330C142
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308744; cv=pass; b=XFrQ0oHqTkB2z9uOl93RTzc/M+lm0kOoJjsrSQ6z2I2r/lnNGQdewLbKVb4mmBIz2Is19/jL6XppVEXNYf0FOtfkZjdwg4/oX4d6MM2ZcqYC838imOqDMP5G6YFg03bdY93DtQ0i1FVQ4CRO+90xkK6eI3eNHUKItMWw8sdtVpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308744; c=relaxed/simple;
	bh=wsD1ZYL4eDq51mvy8c/V3wuNAYI4Xbyh6GSopndl9OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8wcCTAOs2ZeyhlUM1KNHYbtOUHVmliVKbLAjhVVwt5pwrtAtLf5OYE6rUnuLxqYudJyp9GXZn6OtxQUGOLpPjZPQ+U+Xtw/5Gdp+GQDjROVbBODnmJ+HUulhvBhfhqyqvNhO7ZpOvJuYElG3cfcHN8UuGc9hc7L7VJLhWfPFro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YpGPdDHs; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YpGPdDHs"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1419d3416ceso5440708c88.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791308742; cv=none;
        d=google.com; s=arc-20260327;
        b=oeYG69DfUzRs3is9fTIm+ABtznD/moxyTszru89xx4G0ISz+EJMqs78bJPD5ZTNPxP
         rlV3bu1BvoAXcyplbeJxs+rz2ms9hQfyXmvVxD8fxN4x6POBi4oUZHzLBt2PVhkqCMDI
         DJREIVk46Vu10ZmAJnIY+PSPMcoogQ45rIHPfXYryOcgtdJxaPcW/qw94+642nH3LU/O
         2ktGFR+YcLFENN+Gtm7p+PSVmUoiycSDmX8OlZy0bwVlDhvYxOpfnpOXNYkwY+I5KHsr
         SROE6KVNA613RArvXkwtYUJmv4EBShmnS+rjxjBjKb8y+jZysiiUhBGJmF/PLLCarF3/
         +Brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jt5+EDQhQSH/SBkvRXK+m7IPP1sPHmdaTcduOFwaxxY=;
        fh=mhsDu8XSzDO/ra16MjO0N7ccpAuW6mv78+0swztOi88=;
        b=cnqYbydQq8DpVGrSyLN4zVCmVfz8QQ8crZVb0qNIyOfEe1Y4QVJfJF01XdpvU6hD2v
         Oljt1rxh2IG1ow0O4GqcXTnOx8INusi2xA60YHHEoWoeEQ0K00scqUFg7zRp0JLhFF7k
         9kbfmOjrLLD9ZopCN4fI1f3SyeK8+WpVc6oIKNmpoXKARkHW5uk6mjVEjTEdiljywDqB
         RTeLiuksTQb33sXS1oZT0X6F91V7IjIXFns0NB0vgCAEwFWWoseMdNnW2PzTaqb3exTs
         ihOi8v3hhHTCs0IAEq4Q++mYyAP1rENAJHXaHLKoO4izyj3vplPgBzHqnv/b3YfXN87O
         gfpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791308742; x=1791913542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jt5+EDQhQSH/SBkvRXK+m7IPP1sPHmdaTcduOFwaxxY=;
        b=YpGPdDHsGK0gVqLmBffzxKko2Uv+nhGX2XaMkrHLffioJRKOzCW55Pr1Ky07JoKY7X
         coYFgA2MDFKDtw/4rbAY8ctz/5KtyTk+EMF8l1x9xOtCPsVkN3xNlF6RZMM5RWwwkFua
         pzii3qZJJ7nU7j4ZU3t/YY9CxZ7LM+xc1VpYFtt0OU2wb21PDJ6lyJUz4wGtjSmu3/gv
         VgLJ5UePqevXBQWqXyOQtWnHyiXzkZqL0ZYxj+m4eZWKbkZZKyqiolWvDi4gw2Rv1bq4
         J47ODT19FDc7coL/IXsNoh1UEDVgEXf4bB2P67Y3cy1W2WyaeFxkLu88NKtQ5yg7wwYU
         pFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791308742; x=1791913542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jt5+EDQhQSH/SBkvRXK+m7IPP1sPHmdaTcduOFwaxxY=;
        b=M1RN+aRJHDjPjgjntbQ9w1FrZtVnt3iB8CJqhhvohsN0dwhwdQNPELZuUg+j/48oFe
         vOgzCMCCF0WwgHMnShRwxW7iCw8S0yrwet4ICIaoQk1lq24NiuntBohgIwvlJWijAsPq
         czrNyXSEfJ460dX4x1pNVQEjRa2bpE9vc78rAwr7YMoYLdt5JB00y4MjWwhOC6BDneXX
         zw+vFG9RFLtW9XHS4qJxCt8j57QY5rOZ9jT1gfiXqk/ID++6cl6GVITVsjNT11OIGkPo
         Z8XfeuNuV9WUYMiLIKw9L+RuM/JIiXPBICFxNuY4eNZHZsmvFe4xwZzzSf51l9XmBNkt
         rQog==
X-Forwarded-Encrypted: i=1; AKwUvBz5s1ABnMPwmM/0cqu2XEygX5H13sny1HPa7m49BWUaX6dPQX+49KOP0Q+IO+P7wEnh23iyt9o=@vger.kernel.org
X-Gm-Message-State: AFuF++m1hl/H528tw09llcZMnDQPcDbtXnQf8dj0Omk66HyghuYVsub6
	+fZf/T44+AFYfroFzVXwcNqMvqMZ6dvDx9WdgTZxAcTtX6ROdWjfGr2Y2M1WZFOEgkljdlQEPKy
	Y1PBx1ZjJZXoO8ofA151zIkSd8cNfMicfEP7Cd9Z5
X-Gm-Gg: AYBFou2O/U1QVu4mmntS5qtn6x3mQV0PeoYPhVRJw/vH3QYPN9wWyP8JrPbZngTQVXM
	2lVy05Ouv6Y2j4LwHxaZN0srm+EmVykBpl6d93s+3GcGkn8W3ZVHmXCDnk314eN0ZGwNSJYeXQN
	iNumoEqlqecHvJxcX2xNg2jirCwdo3BTNh2hZ+MOY+rpRj4pKyiR119B7moVxK+2UiMCngTt7W1
	bSJs/RBHqcWdnNdYz36Chk9wc0PpZGxEdoahf6m7b1SRDFsYnhk2RIivRBbKSNDh86XzzEBFseE
	UJC96deNNUiv6KEeIi8DzOOLMwRGgLhesfkGz4gphGKCVmslmk0xuxmo+Q9ydYz31BSdYOvKBBz
	EeODKsZIIzFsop5ElijUEX8q3bHVisyzIgMe1HEP1JF215d/fhTzk1O0+r1R65aqgv8V0IM8Ker
	NBzy0vMQqy240M0IaGt1+DzmMd
X-Received: by 2002:a05:701b:221c:b0:143:8860:afa1 with SMTP id
 a92af1059eb24-151c426186dmr17137400c88.46.1791308740548; Tue, 06 Oct 2026
 10:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001204752.2572265-1-kuniyu@google.com> <20261006081237.GA582799@shredder>
In-Reply-To: <20261006081237.GA582799@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 6 Oct 2026 10:45:27 -0700
X-Gm-Features: AclHuK8isKnax9kiLXP3UDFzvVzxq5JrQ3ClBrmnxerOl3otw7aVD0pu80P0Y_Q
Message-ID: <CAAVpQUAVg-8TURWpG3mtO9gAZY+J9L1XWGkM-GJ_xUG4G3phuA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 0/6] ip: Batch flushing uncached routes per
 batched device unregistration.
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chris J Arges <carges@cloudflare.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 1:12=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Thu, Oct 01, 2026 at 08:47:12PM +0000, Kuniyuki Iwashima wrote:
> > Chris J Arges reported high RTNL contention during cleanup_net()
> > caused by rt_flush_dev() and rt6_uncached_list_flush_dev() iterating
> > over the global per-cpu uncached route lists for every netdev in
> > dying netns [0].
> >
> > This series resolves the issue by batching the uncached route
> > cleanup after __rtnl_unlock() in netdev_run_todo()
> >
> > [0]: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3=
-0-30493a37b6eb@cloudflare.com/
> >
> >
> > Changelog:
> >   v3:
> >     * Add patch 1 ~ 4
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> For next time:
>
> The cover letter should explain how the patches fit together. Otherwise
> it's up to the reviewer to figure it out.

Sorry, I should have added it.

> The dependency between patches
> 1 and 6 is not immediately clear. My understanding:

Yes, correct.

Thanks !


>
> Patch 1 is needed so that the IPv6 uncached lists are initialized before
> they can be traversed for devices that are unregistered due to failed
> initialization.
>
> Patch 2 is a cleanup that is made possible by patch 1.
>
> Patches 3-4 are preparations for patches 5-6 that are going to walk the
> uncached lists once per batch of unregistered devices. If a dst entry
> that points to an unregistered device is put on the list after the walk,
> nothing will clean it up after patches 5-6.
>
> Patches 5-6 avoid walking the uncached lists for every device being
> unregistered. Instead, walk the lists after one or more devices were
> unregistered and delete from the lists entries that point to such
> devices.
