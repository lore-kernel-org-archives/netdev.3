Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6344CC262;
	Tue, 15 Sep 2026 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513068; cv=none; b=G9EdKJuQyvBOR2IhuCpGl7cnQTP1SGDNzUuO76J0bw0u6rsROVr29QvffaSIo6EAKPMck71cQVo5PdwT5BNRrIBhZmSHooC0q0mHLbTR6MHPkxY9JnsPYtp6PBoQ3m/UKElXN5k+GkfgLhN7+cA1wMh6WeBw6RQPsLsDtDKebJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513068; c=relaxed/simple;
	bh=yhsNj6jWXACE+p3ihRz3xHZoHiKrSyiTkrV7NdIjveM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V2HHM/PyxReCuaDixlSDv7KCqNaZFjaYC4g4C1jDI1aGUo60zuk0bADaaNs/mzr5aYlwlYqhXNBuBCKQdVBGjn2I4wtxgqbnUUFGWHEi9M7uLhqQJ/B6w89vLL364o7JXAfvJIwiMmcKC51xU2IfSyVmDLAQRB/LsqXVZj1cD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwyZEvy/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwyZEvy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17161F000FF;
	Tue, 15 Sep 2026 22:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789513066;
	bh=/moa0L7C2Qasuf13H754ngTSS1k8gdSY/BtIHUoI/fs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gwyZEvy/ZtU4bqAfcFidU2UZduoX8Vz2zk+jBAtLBnFblCV89mqP+vbWk5wjlETzp
	 la8H7sTYyfzVa6T5x7dKpUynjT/BJf7wX20YcWr1D675YWwlyQOgPWrqs2FLR8Av6S
	 J+tNWLf9rUZwBW0L5JIVezPijqQXiPcELsxbX6BjiwxCuJSNhbRwFMuQsI7Tk9BOh4
	 huUSR8Mp5qIp6TUKys9zqDNSIjzO7uAlFrAMNPXpR5sYYZTiAMuKkYXqGNL3wlBa6n
	 OgVClvFTYoF4EnQBbo68kmLW1wa2JUNquQk5SSoGVT4073xCYDR0SzkupKYZkBRXYR
	 eB8bBN8nTgdiQ==
Subject: Re: [PATCH net v10 13/14] afs: Fix uncleared op->call pointer
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 22:57:45 +0000
Message-ID: <178951306557.22033.18218417627125166965@kernel.org>
In-Reply-To: <20260914151340.3227501-14-dhowells@redhat.com>
References: <20260914151340.3227501-14-dhowells@redhat.com>
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
issue(s) to consider:

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

- [Medium] The Fixes: tag is too narrow.

Pre-existing issues:
- [High] The asynchronous fileserver-rotation peer of the loop fixed here
  does not handle the 'issue helper returned without creating a call'…
- [High] An RPC that was never issued because of an allocation failure is
  reported to userspace as a successful operation.

--

afs: Fix uncleared op->call pointer

This adds op->call = NULL after the afs_put_call() in
afs_wait_for_operation(), so that a subsequent fileserver rotation
iteration cannot observe a pointer to a call that has already been put.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com

A couple of questions about the Fixes: tag and the changelog wording, and
two observations about neighbouring paths that the new op->call = NULL
interacts with.

> Fixes: 6f2ff7e89bd0 ("afs: Don't put afs_call in afs_wait_for_call_to_complete()")

[Severity: Medium]
Is this tag scoped correctly?  6f2ff7e89bd0 moved the afs_put_call() out of
afs_wait_for_call_to_complete() and into afs_wait_for_operation(), but the
stale op->call looks like it predates that move.

At 6f2ff7e89bd0^ the loop in afs_wait_for_operation() reads:

	if (op->call)
		op->error = afs_wait_for_call_to_complete(op->call, &op->ac);

and the tail of afs_wait_for_call_to_complete() that the blamed commit
removed was:

out:
	_debug("call complete");
	afs_put_call(call);

so the call was already freed with op->call left pointing at it, and
git grep 'op->call =' at that revision finds only the assignment in
afs_make_op_call().  Since the tag names a v6.7-era commit, would the
older stable trees be skipped by the backport tooling while carrying the
same stale pointer?

> Fix uncleared op->call pointer in afs_wait_for_operation() lest server
> rotation occur and try to reuse the call.

Could the changelog say what the reuse actually is?  On a later rotation
iteration where the issue helper bails out through afs_op_nomem() without
assigning op->call, the stale pointer is handed to
afs_wait_for_call_to_complete() and afs_put_call() a second time, i.e. a
use-after-free of a freed afs_call rather than just a "reuse".

> diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
> index 20801b29521d1..94fa65548d712 100644
> --- a/fs/afs/fs_operation.c
> +++ b/fs/afs/fs_operation.c
> @@ -297,6 +297,7 @@ void afs_wait_for_operation(struct afs_operation *op)
>  			op->call_error = op->call->error;
>  			op->call_responded = op->call->responded;
>  			afs_put_call(op->call);
> +			op->call = NULL;
>  		}
>  	}

[Severity: High]
This is a pre-existing issue and not introduced by the patch, but with
op->call now guaranteed to be NULL at the top of every iteration, what
happens to an -ENOMEM from the issue helper?

Each iteration of the loop starts by clearing the per-call state:

		op->call_responded = false;
		op->call_error = 0;
		op->call_abort_code = 0;

and the issue helpers bail out on allocation failure with:

	call = afs_alloc_flat_call(op->net, &afs_RXFSFetchData, ...);
	if (!call)
		return afs_op_nomem(op);

while afs_op_nomem() in fs/afs/internal.h only records:

static inline void afs_op_nomem(struct afs_operation *op)
{
	op->cumul_error.error = -ENOMEM;
}

With op->call NULL the completion block above is skipped, so op->call_error
stays 0 and AFS_OPERATION_STOP is not set.  afs_select_fileserver() then
evaluates the previous "result":

	int error = op->call_error, ...
	switch (op->call_error) {
	case 0:
		...
		error = afs_update_volume_state(op);
		...
		fallthrough;
	default:
		/* Success or local failure.  Stop. */
		afs_op_set_error(op, error);

and afs_op_set_error() assigns unconditionally:

static inline int afs_op_set_error(struct afs_operation *op, int error)
{
	return op->cumul_error.error = error;
}

Does that erase the recorded -ENOMEM, so afs_wait_for_operation() takes the
!afs_op_error(op) branch and runs op->ops->success(op) on an afs_status_cb
that was never filled in?  For a store that reaches
afs_store_data_success():

	if (!afs_op_error(op)) {
		afs_pages_written_back(vnode, op->store.pos, op->store.size);

which would mark the pages written back and return success from write(2)
although no FS.StoreData was ever sent.  For create/mkdir, would
->success() and ->edit_dir() instantiate an inode and a directory entry
from a zeroed status and fid?

[Severity: High]
This isn't a bug introduced by this patch either, but the asynchronous peer
of this loop has no equivalent of the "no call was created" handling that
the if (op->call) test provides here.

In afs_issue_read() the async branch is:

		if (!afs_select_fileserver(op)) {
			afs_end_read(op);
			return;
		}

		afs_issue_read_call(op);

and afs_issue_read_call() returns void without inspecting op->call or
op->cumul_error:

static void afs_issue_read_call(struct afs_operation *op)
{
	op->call_responded = false;
	op->call_error = 0;
	op->call_abort_code = 0;
	if (test_bit(AFS_SERVER_FL_IS_YFS, &op->server->flags))
		yfs_fs_fetch_data(op);
	else
		afs_fs_fetch_data(op);
}

If afs_alloc_flat_call() fails in afs_fs_fetch_data()/yfs_fs_fetch_data(),
afs_make_op_call() is never reached, so op->call stays NULL and no rxrpc
call exists.  All the async completion work hangs off an existing call via
afs_fetch_data_async_rx() -> afs_read_receive() -> afs_end_read() ->
afs_fetch_data_notify() -> netfs_read_subreq_terminated().

Does that leave the netfs_io_subrequest unterminated for readahead and iocb
reads, with afs_put_operation() never called and the operation's
key/volume/server_list references leaked?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com
