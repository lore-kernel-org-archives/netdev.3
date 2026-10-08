Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24738B14F;
	Thu,  8 Oct 2026 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476008; cv=none; b=EsqyNu4OiuL+XPjPdQL6W0765vOwmh+96KQvCiaJwODEOhzce3cZKVcRzZNIkfrykm3pE6Mq2UqnzjvOZt9WWnamjAdD98xD6fkXNuER3TD56OxqdA/D14ZtWUtFnwt/FLHgH4WMF4PIP28cYqTKkFmn9ujTOedq/PniX3I2YR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476008; c=relaxed/simple;
	bh=vxumENb3U7HAA0xUHGe3qMbSs3zMs36H/o3FdLPn2Rc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qt+DPaaA5Rta0nFRdf3jFicjE1UmKQZ2sN8yBYUhM9XYjsBWefKGbR+WxA0jKXIO8sO+fNdQv/LUCgFzqWz7KBOApAZn8WdcEalQeRXSy2jaeZMTomQYWWgBRxrIepn84tXmiEP97/0cTrt3nd5VLmSloteYi/OXyliY/mvQByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acOafNUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acOafNUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B481F00893;
	Thu,  8 Oct 2026 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791476006;
	bh=56ecmznjCwHAEsSlbjzQCvjNzAK9i9n7gZaRpdVf6vQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=acOafNUIXgcDO5zVclz5Q3WyneVsMOTuJxqf7YvoPa7/Igi+ggEnt3KxvoGGX6G0D
	 wOwDgoO6dFNGr844VB4s5eEWgO0oVejtomN215f84qUTVDqbO8dggEd7X8ma103siz
	 26/GsPoKps8wA+8VXRFfAM9ZbQEOfR6woUvNF32mqUYWnlqxSK76cnG4eSx8vPbF1r
	 AVj55qn5FpqI6939jg8/3cagl5D/Meqf3HWwMI8pOEGPcJGpYXtwYJHXRY5DvqtJzo
	 rlcQxrU4cheB9GkwnxfuihGdzpCwT2A9xxnMJ85bM0tVuPsQRze/ByQcn2FgQQAoRk
	 P7GdZyFBJ4C5w==
Subject: Re: [PATCH net v12 06/15] rxrpc: Fix aborting in rxperf test server
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
Date: Thu, 08 Oct 2026 16:13:25 +0000
Message-ID: <179147600540.434549.14704300923711345518@kernel.org>
In-Reply-To: <20261006133011.531806-7-dhowells@redhat.com>
References: <20261006133011.531806-7-dhowells@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not describe what this patch actually
  changes.

--

rxrpc: Fix aborting in rxperf test server

This patch changes rxperf_process_call() so that any send error from
rxrpc_kernel_send_data() aborts the call. Previously it aborted only on
-ENOMEM. The new abort uses RXGEN_SS_MARSHAL and the new
rxperf_abort_send_error trace reason, and the rxperf_abort_oom trace symbol
is removed.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> rxrpc: Fix aborting in rxperf test server
>
> Fix rxperf_process_call() to always abort if it gets a send error rather
> than only aborting on ENOMEM.

[Severity: Low]
Does this description match what the patch changes by itself?

The subject and the Fixes: tag suggest that some send errors used to leave
the call un-aborted. That was not the case before this patch.

Both send sites in rxperf_process_call() returned the error to
rxperf_deliver_to_call(). That function already aborted the call for
nearly every error:

net/rxrpc/rxperf.c:rxperf_deliver_to_call() {
    ...
		ret = call->deliver(call);
		if (ret == 0)
			ret = rxperf_process_call(call);

		switch (ret) {
    ...
		case -ENODATA:
		case -EBADMSG:
		case -EMSGSIZE:
		case -ENOMEM:
		case -EFAULT:
			rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
						RXGEN_SS_UNMARSHAL, ret,
						rxperf_abort_unmarshal_error);
			goto call_complete;
		default:
			rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
						RX_CALL_DEAD, ret,
						rxperf_abort_general_error);
			goto call_complete;
		}
    ...
}

Only three errors skipped the abort:

  - -ECONNABORTED, because the call has already ended
  - -EINPROGRESS
  - -EAGAIN, which needs MSG_DONTWAIT or an expired send timeout, and
    rxperf uses neither

So at this commit, the visible changes seem to be:

  - The peer now sees the abort code RXGEN_SS_MARSHAL instead of
    RXGEN_SS_UNMARSHAL or RX_CALL_DEAD. This is because
    rxrpc_propose_abort() only acts on the first abort proposal.
  - The trace reason becomes "rxperf-send-error", and "rxperf-oom" is
    removed.
  - rxperf_deliver_to_call() then makes a second abort proposal, which has
    no effect.

The underlying goal is to make rxperf_process_call() the only place that
aborts on a send failure. That only seems to take effect with the later
commit "rxrpc: Fix error handling in rxrpc_send_data()", which makes
rxperf_process_call() return void.

Could the commit message mention the abort code change and the dependency
on that later commit? Otherwise, a stable backporter going by the Fixes:
tag may assume this patch alone fixes calls that were left un-aborted.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006133011.531806-1-dhowells%40redhat.com
