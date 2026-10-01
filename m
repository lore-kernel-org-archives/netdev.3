Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF253126C0;
	Thu,  1 Oct 2026 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897284; cv=none; b=kEtH3AkQQPJsZ453j0Zg4AqM0H+03BYSQpg8PAzvwmvgOI2ruCLJt9lJPStRfOoOUxzvitQjnTdVlrgHIMV0w5j4O46XaejiG+cpXGsGLQMxiDTLQO81s8BtrWvsYibTNobYVjXuTL0k8OULLsdooff2ibMj9KweLrgzIrnaeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897284; c=relaxed/simple;
	bh=MIi/beoN2C2LmeLrmSclps3kf9tF0OWCYNqsXq2Oa30=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=siSaBkWPh7+ZPrY6ST+WZMu6EQejqUDmxrVP5ei8G8gormDtiyyvakfnuoRRNw38u3PzmU7Wx54/hPyfk1RHf9fag36y0yt7BxogPMlHRNvQjGf4JCCxXzS80xj7jexF/pI3AJrGm0kF3vFdjuUAJMw3OaSFdvPx5Y8QbKtRzBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+lPJ2ou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+lPJ2ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAEB1F000FF;
	Thu,  1 Oct 2026 23:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790897282;
	bh=NxJLfvlrAiUPHuPT+4nMqczjBQ0Hw9rw7hqR0HavCWs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W+lPJ2ouLTHHFJ5TSnvav4NHl04+YEniB9AWWrNzXhGf5+z58ZYNARiAaLz7rusj5
	 H8fzufDOttnboCeWY/sFL9hSOuq83KJzbFC8pi1NqtnUuiSaCZAPmbyDIliLBth6kp
	 XfKJ6Z8w/Hvyr+j4Arx9CE8MYuWyj9uX5eMuJ49aotdDMLs3VellWsnw30sbldoiPT
	 1qxqH+SNYxPS7TI0MAgQ6mfxkV3xUUkN9VU1BouPl6JCnyyv2g3u0E4LCNkZmLLTH+
	 l2bDM4CmoSrMdWEMqNlId53wpIiKE68ZLMtkblxtGScnhCMU+T/wbbF+3VqmhafyjC
	 JcpCaVNARV5hg==
Subject:
 Re: [PATCH net-next v1 1/1] eea: Drop temporary buffer by using %pEp directly
From: netdev-bot+sashiko@kernel.org
To: andriy.shevchenko@linux.intel.com
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, guwen@linux.alibaba.com,
 lulie@linux.alibaba.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 01 Oct 2026 23:28:01 +0000
Message-ID: <179089728102.434549.12368098081790653201@kernel.org>
In-Reply-To: <20260929082722.3368741-1-andriy.shevchenko@linux.intel.com>
References: <20260929082722.3368741-1-andriy.shevchenko@linux.intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In eea_adminq_config_host_info()
  (drivers/net/ethernet/alibaba/eea/eea_adminq.c), the patch swaps…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the escape
  flags used in eea_adminq_config_host_info() do not escape anything.

--

eea: Drop temporary buffer by using %pEp directly

In eea_adminq_config_host_info(), this commit replaces the
string_escape_str() call followed by "%s" with a direct "%pEp" specifier.
It also drops the on-stack temporary buffer that held the escaped copy of
the device reply string.

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
> index 73d0caf257006..d17575a768900 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_adminq.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
> @@ -522,16 +522,8 @@ void eea_adminq_config_host_info(struct eea_net *enet)
>  			dev_warn(dev, "The hardware-driven state validation may be abnormal.\n");
>  
>  		if (rep->has_reply) {
> -			char buf[EEA_HINFO_MAX_REP_LEN] = {0};
> -
>  			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
> -
> -			string_escape_str(rep->reply_str, buf, sizeof(buf),
> -					  ESCAPE_NP, NULL);
> -
> -			buf[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
> -
> -			dev_warn(dev, "Device replied: %s\n", buf);
> +			dev_warn(dev, "Device replied: %pEp\n", rep->reply_str);

[Severity: Medium]
Will this print only the first byte of rep->reply_str?

%pE does not look for a NUL terminator. It takes the buffer length from
the field width, and when no width is given it uses 1 byte:

lib/vsprintf.c:escaped_string() {
    ...
	len = spec.field_width < 0 ? 1 : spec.field_width;
    ...
}

Documentation/core-api/printk-formats.rst says the same:

    If field width is omitted then 1 byte only will be escaped.

The removed code escaped the whole string, because string_escape_str()
calls string_escape_mem(src, strlen(src), ...).

With this change, a reply of "abc" would be logged as "Device replied: a".
If reply_str[0] is NUL, the NUL byte is copied raw into the log record,
because ESCAPE_NP alone passes it through unchanged.

The commit message describes this as a like-for-like conversion. Should
the length be passed explicitly, for example:

	dev_warn(dev, "Device replied: %*pEp\n",
		 (int)strnlen(rep->reply_str, EEA_HINFO_MAX_REP_LEN),
		 rep->reply_str);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
does ESCAPE_NP on its own actually escape anything here?

The old string_escape_str(..., ESCAPE_NP, NULL) and the new %pEp both
select only ESCAPE_NP. The 'p' makes flags non-zero, so escaped_string()
never falls back to its ESCAPE_ANY_NP default:

lib/vsprintf.c:escaped_string() {
    ...
		case 'p':
			flags |= ESCAPE_NP;
			break;
    ...
	if (!flags)
		flags = ESCAPE_ANY_NP;
    ...
}

In string_escape_mem(), printable bytes pass through at the ESCAPE_NP
check. A non-printable byte skips the ESCAPE_SPACE, ESCAPE_SPECIAL,
ESCAPE_NULL, ESCAPE_OCTAL and ESCAPE_HEX branches, because none of those
flags is set. The final escape_passthrough() then copies it raw:

lib/string_helpers.c:string_escape_mem() {
    ...
		if (!(is_append && in_dict) && isprint(c) &&
		    flags & ESCAPE_NP && escape_passthrough(c, &p, end))
			continue;
    ...
		escape_passthrough(c, &p, end);
	}
    ...
}

The kernel-doc for string_escape_mem() also notes that "It doesn't make
much sense to use either of them without %ESCAPE_OCTAL or %ESCAPE_HEX".

The device fills rep->reply_str through the admin queue response, and the
driver only forces the last byte to NUL. As a result, CR/LF, ANSI escape
sequences and high-bit bytes from the device reach the kernel log
unescaped.

Since this line is being rewritten anyway, could it use a flag set that
does escape, such as %*pE (ESCAPE_ANY_NP), %*pEhp or %*pEop, along with
an explicit width?

>  		}
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929082722.3368741-1-andriy.shevchenko%40linux.intel.com
