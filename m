Received: from mta1.migadu.com (out-127.mta1.migadu.com [95.215.58.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF8242D65
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791008649; cv=none; b=W6yKZPlCEVGQxGBISdlCFm/tpZ5o5k3TaJWETEVrhtjlLLHdtX1Ni2ZV+dA2Ffg37etZ8mbhiFWNXAPgfcx8XfIfIZ48/Gj5KJddwn5Tj9rsZw4H0LKqyr1uieCsx6PX/FNUzGu3FhmHbYfFAd0/09L3P4Dqt7YZUf4cbqh4R6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791008649; c=relaxed/simple;
	bh=uXr2q7UZes+MeSF6RarEYCzlQMvAzuwsQ0pseuoaz2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMYQ876TJ/lS03yHZrGpl3E9qLAdXLRadrnwFBwKkLFIComdJ/b9QbfVfKjH0vIYBPYN8qwNOfQPcYWIOlB/2MN9QoXrR32RSlxPsOx6Lpqz9hiZcGj0uR42eHSB6RK0rcwXArmpowtvPiYY28HCv5VxTIao+S0/UHDJw6m2Y5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I3ynhin+; arc=none smtp.client-ip=95.215.58.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I3ynhin+"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uXr2q7UZes+MeSF6RarEYCzlQMvAzuwsQ0pseuoaz2I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791008644; v=1; x=1791613444;
 b=I3ynhin+y1MOY6yewIJDVRDoe7ViJIxwHoMLR1xw4GwlQgKju5xQSSCe6lWayNvTrUXa2efz
 Pk3KyrIaw9jPqVvQhtG/TC7xI6ejdH4dsMMvMdImiPhpgBvIbWj2OLlFLsVicPn0NFvTgb4XFzY
 PPfWp9X+tzaIsiEbGvZt7d5M=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id d7c4947124629513;
	Sat, 03 Oct 2026 06:24:04 +0000
X-Mizu-Trace-ID: d7c4947124629513
X-Migadu-Flow: FLOW_OUT
Date: Sat, 3 Oct 2026 14:23:53 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/6] tools: ynl: convert enum selector to
 string for sub-message parsing
Message-ID: <asCfefn6IADLNDtD@fedora>
References: <20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn>
 <20260930-ynl_rt_encap-v3-2-4106c21b9ee7@kylinos.cn>
 <20261001015134.963061F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001015134.963061F00898@smtp.kernel.org>

On Thu, Oct 01, 2026 at 01:51:34AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] ynl: early return 0 aborts entire parsing loop on unknown sub-message
> - [Medium] ynl: invalid C code generated for external enum selectors
> --
> 
> commit f2c434cd3f008807f1723585dcbfd634aa3f28b7
> Author: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> tools: ynl: convert enum selector to string for sub-message parsing
> 
> YNL sub-message parsing expects a string selector for strcmp(). So for
> non-external enum selectors, convert the integer value to its string form
> via the family's {enum}_str() helper. This enables correct decoding of
> sub-messages keyed by enum values.
> 
> > diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> > index 15c79849c6096..783242537fe48 100755
> > --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> > +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> > @@ -951,13 +951,31 @@ class TypeSubMessage(TypeNest):
> >              sel_var = f"_sel_{sel}"
> >          else:
> >              sel_var = f"{var}->{sel}"
> > -        get_lines = [f'if (!{sel_var})',
> > -                     f'return ynl_submsg_failed(yarg, "{self.name}", "{selector}");',
> > -                     f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",
> > -                     "return YNL_PARSE_CB_ERROR;"]
> > +
> > +        local_vars = None
> > +
> > +        if self.selector.is_enum_val():
>             ^^^^
> 
> [Severity: Medium]
> Will this generate invalid C code for external enum selectors?
> 
> The condition doesn't check if the selector is external. If a YAML spec
> defines a sub-message with an external enum selector, it appears this will
> generate a non-existent structure member access for the presence variable:
> 
>     pres_var = f"{var}->_present.{sel}"
> 
> and try to pass the string pointer to the enum string helper, which expects
> an integer. Should this check include `and not self.selector.is_external()`?

OK...

> 
> > +            enum = self.family.consts[self.selector.get_enum_name()]
> > +            pres_var = f"{var}->_present.{sel}"
> > +            parse_sel = f"{sel}_str"
> > +            local_vars = [f'const char *{parse_sel};']
> > +
> > +            get_lines = [
> > +                f'if (!{pres_var})',
> > +                f'return ynl_submsg_failed(yarg, "{self.name}", "{selector}");',
> > +                f'{parse_sel} = {enum.render_name}_str({sel_var});',
> > +                f'if (!{parse_sel})',
> > +                'return 0;']
>                  ^^^^
> 
> [Severity: High]
> Does returning 0 here abort the entire parsing loop?
> 
> If a generated YNL parser encounters an unrecognized sub-message enum
> selector (for example, sent by a newer kernel), it looks like `return 0;`
> executes directly inside the attribute loop of the parsing function.
> 
> This would silently abort processing the remainder of the Netlink message and
> drop all trailing attributes without returning an error. Is it possible to
> skip the attribute and continue parsing instead?

OK, I will use continue then.

Thanks
Hangbin
