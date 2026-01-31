Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC002DECCC;
	Sat, 31 Jan 2026 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821536; cv=none; b=RqowHFPjnUuCnb2u8Q1fwG3qweH8317tt5xa/L1dtvc+9RArE6HnUSJsdDGOPgD/XKFY7gMf/iU8QMRhIVs/lNEwskhhzgHlRzLC1sb34F+IVFyS+204j8GlxHMGTM4gh4XXiHko2r3ecD6498zbDh3pWYNp+AiZyrc7jQ4kiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821536; c=relaxed/simple;
	bh=0jI616kk35GV4rCmyrPDMjQwclX9zQXcyVZFyIWp20U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMjQ27wryJgCRMxBHJMebBSaLDxK01ktYCZAOrdSPQXXL5FDWl98LhEd4w9OVexk5aL3U11f69wOLl4etJ7CdTBrVrDP4MLsPmi3NGWavpjLZj61iMOm3mctfOwmJmjWLb5zI3tN7Z4yxyIywkLr1Q/aKU89z9Vm6WXQqhSwoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhtK2hGG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhtK2hGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1D4C4CEF7;
	Sat, 31 Jan 2026 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769821535;
	bh=0jI616kk35GV4rCmyrPDMjQwclX9zQXcyVZFyIWp20U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LhtK2hGGZHISVuVtnVdsIKijTl7Wwe8x7MkYfRcM7sQth7d0gD5G+bAF4305CDn+u
	 Ie3/xiFiw4VoJVjwm4lGz6HgsAFVbKOBu/kClFxhxEwOx8v81Y8AXKHNWVmCl7z9jE
	 LmC+a7C20jgQNqzyHfGIqlgAWnrS0Qu3iE9zu2IzcxLcKIeR72i73Z+izd6Ko8iLAQ
	 tTvgG8fQ32e73oXcvT+Gl8Zv597zW1BZN8MMnQUHHkLYjkkHasS8oBCdHTgzENnlS1
	 bVImwNMj7114gj6tpKgH6QoHapdIm2d/ZqJSZxLStqHvWoClgwNq5yOw76vgZlILj+
	 FMUhHZMl/mO+A==
Date: Fri, 30 Jan 2026 17:05:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Chen <me@linux.beauty>
Cc: Jonathan Corbet <corbet@lwn.net>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, Pratyush
 Yadav <pratyush@kernel.org>, Eric Dumazet <edumazet@google.com>, Neal
 Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Randy Dunlap <rdunlap@infradead.org>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Petr Mladek <pmladek@suse.com>, Feng
 Tang <feng.tang@linux.alibaba.com>, Kees Cook <kees@kernel.org>, Li
 RongQing <lirongqing@baidu.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin
 <safinaskar@gmail.com>, Frank van der Linden <fvdl@google.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 3/3] liveupdate: suppress TCP RST during post-kexec
 restore window
Message-ID: <20260130170533.257db5fb@kernel.org>
In-Reply-To: <20260130145122.368748-4-me@linux.beauty>
References: <20260130145122.368748-1-me@linux.beauty>
	<20260130145122.368748-4-me@linux.beauty>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 22:51:19 +0800 Li Chen wrote:
> During a kexec-based live update, userspace may restore established TCP
> connections after the new kernel has booted (e.g. via CRIU). Any packet
> arriving for a not-yet-restored socket will hit the no-socket path and
> trigger a TCP RST, causing the peer to immediately drop the connection.

Can you not add a filter to simply drop those packets until workload is
running again? It'd actually be less racy than this hac^w patch ...
