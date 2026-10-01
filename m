Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5353E168C;
	Thu,  1 Oct 2026 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840030; cv=none; b=Qo9qizxIJkJLlUf7wlI0BFlbGzI+RAwaiXWALiA3KmPvZkEzyoltbrCI8Vy+KEQaQUVWeQsh9zut6umHVrwD4V3rkmeDkdRDonfw1KlTm8PLzseMIQq/w/8iCrJ4C0JhemFcb10YGrtx+8JaHnMAyoQtVlTqvzViv17B1HubCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840030; c=relaxed/simple;
	bh=HCbe2iSZ9MjXXALiOHe07k/Dr2KTH5oWsn9wBTYy+Ds=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5Zvl+vON2frr5ZV4cSKgNElzqFyN4BtG2jTP/gQicOIjMVmh2ASljWXBHT/GR3l2SqoFhi/vLF4sDPyNJZP1seAAl84jmK07SbE5WkGaY7hJ4HawGtDpWP2uw5UV4LI0XxioXIlvfF6jDn2VmynGf2LrfOx1hsonJeOFGWHMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJV9rcvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJV9rcvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73AA1F000FF;
	Thu,  1 Oct 2026 07:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790840028;
	bh=g68NssCbHV1Z0j/xt9LYSA9TUqJSO3DMsbZaH2PG3so=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SJV9rcvNm3tyxxEVwsraKgx6DeF4CFTWhgq0Z+axLzDxcpwTnQC+c2ANxKFAMMXaC
	 LXDH+xX4qULFYvKVQgVsTV8nSdtFcyIBg1fLQD9ekQ66IueRu0pfVanqVlAIHHy7q7
	 43tPVcmsnAfTrPoLUINWS2T/huBQIUMeVdOMZpU/8SjpsmVtbiuqRp4yx+LeWbJG7Y
	 mROhg5fx+YbJV19Sog4sfYwBYpMv2+5aQkdHG2oQCFzvwY2LV1oVJa3xFinzdYkT4n
	 LP5VQpODgIse5dU5NbYW45Wcba6mEijximapj6HClPZe24k72fVfucqwbL5g+luDRh
	 1orq0OUzADXaw==
Subject: Re: [PATCH net-next v2] docs: netdev: additional info requirements
 for bug fixes
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, nb@tipi-net.de,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org
Date: Thu, 01 Oct 2026 07:33:47 +0000
Message-ID: <179084002725.434549.277511708648912832@kernel.org>
In-Reply-To: <20260930163109.3910509-1-kuba@kernel.org>
References: <20260930163109.3910509-1-kuba@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new 'Bug fixes' section in
  Documentation/process/maintainer-netdev.rst applies to "All bug fixes"…

--

docs: netdev: additional info requirements for bug fixes

This commit adds a "Bug fixes" section to maintainer-netdev.rst. The
section requires fixes to state how the bug was discovered and validated,
and how the fix was tested. It also asks for short reproducers to go in the
commit message, with longer ones linked online.

> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index 1739d9f856c3b..df220a9654387 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -283,6 +283,38 @@ as a patch to the list with a commit message explaining the technical
>  problems with the reverted commit. Reverts should be used as a last resort,
>  when original change is completely wrong; incremental fixes are preferred.
>  
> +Bug fixes
> +~~~~~~~~~
> +
> +All bug fixes must state how the issue was discovered and validated,
> +and how the fix was tested. This should be done in plain English, not with

[ ... ]

> +If the discovery method does not imply the issue was triggered, the commit
> +message should describe the validation, i.e. how the bug was confirmed
> +to be real. The commit message must disclose whether reproducing the issue
> +required modifying the kernel (e.g. inserting a delay to widen a race, or
> +writing a loadable module to issue the right sequence of calls) or using error
> +injection. The reproduction steps should be included in the commit message
> +if they are short (roughly 10 lines or fewer); longer reproducers can be posted
> +online with a link included.

[Severity: Medium]
Could this conflict with Documentation/process/security-bugs.rst for fixes
to bugs that were found with AI tools?

The new section covers all bug fixes. It asks for short reproducers in the
commit message and a public link for longer ones.

security-bugs.rst says bugs found with AI assistance must be treated as
public, and then says:

  case, do not publicly share a reproducer, as this could cause unintended harm;
  just mention that one is available and maintainers might ask for it privately
  if they need it.

It says the same thing again in the AI tools section:

  Note that since the
  report will be posted to a public list, the reproducer should only be
  shared upon maintainers' request.

The Security fixes section later in maintainer-netdev.rst tells people to
use the mailing lists and not contact the netdev maintainers directly. A fix
for an AI-found security bug in networking code would therefore be posted
publicly, and the reproducer would stay in git history.

For that case, the new text says to publish the reproducer and
security-bugs.rst says not to. The commit message says AI-generated patches
are the main target, and security-bugs.rst is written for the same group.

Would it help to add an exception for security-relevant fixes here, or a
pointer to security-bugs.rst, so the two documents agree?

> +
> +The testing statement should explain whether the fix was tested against the
> +reproducer and against kernel selftests. If the bug is in a hardware driver,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930163109.3910509-1-kuba%40kernel.org
