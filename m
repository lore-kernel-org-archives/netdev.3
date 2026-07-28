Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386842BE9E;
	Tue, 28 Jul 2026 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240674; cv=none; b=Jdv6z3aDyj7yJpHYQkKv596y0G07b8H/Mw4PgQc1jh73nDhiRY3yOMQQ3WdHLWgi8rVmbrjxrND8IWoMklZqaMJywy7WeTANo7iXvON7gH288IksBb+uHiWlzqm0eoSpsI/9Mw2k7cUteh+jte0vDNgBbUyTY/gNewEUK7MX02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240674; c=relaxed/simple;
	bh=RdRbcYo4YQw8o2tm290WjpQUsK+BVcHblmsguTxjyj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8k0a6uIjwOV3KNwQcs+jdfdlrEJ2TSMh1bRuE/UJ2i7QB+s7zr0wSmHTbhaTeIMGH7glk5bx+zQLwgZ/3Hd4QA7lfU4UKmdePH1HFiAF5LSZAvq28jUAR+c+Lloa7Kj5c4qgRVKunAPngmy9BpqhObx6yay1UXt+xfyKrp2D2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLrFWXCB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLrFWXCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D8C1F000E9;
	Tue, 28 Jul 2026 12:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785240673;
	bh=buB0X43QUK9P3Fy3/obDOOcqSvxEKw3BsEa0Y+/pzxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GLrFWXCB8m434h7EWqtxQubxsFveucC9g0WzH6IkgkOvZR3/BUqyHCMaef2E3Flys
	 ywA5NaxZzNlEEi1WyU81zNgbqoKYw/8iMznnOZ+4t63PFncorqPIKDV/y6zZt91W3b
	 EMDUabgfIyMdqzJSlS5+c0l8d+uflUYnvRMuutsSOm/drd3jHkp3xRysfLJv22NIH6
	 skQewYPhZ5BJf6TdPsSoT3jvchScvXkDs+RFo9YDw0WovmAT5Yjrl5ZdUWeKbRGrQy
	 T4gdRREhrkf5rpcdzsvNsUFNBVEZms6u/mCz52iyoz4YsVuRhXuF/5AILk/kVQVGwk
	 ocDwRUOzmbb3A==
From: Simon Horman <horms@kernel.org>
To: bestswngs@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu
Subject: Re: [PATCH net v2] nfc: digital: fix use-after-free in nfc_digital_unregister_device()
Date: Tue, 28 Jul 2026 13:10:43 +0100
Message-ID: <20260728121043.896478-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723174450.1015153-2-bestswngs@gmail.com>
References: <20260723174450.1015153-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260723174450.1015153-2-bestswngs@gmail.com?part=1
---
Subject: nfc: digital: fix use-after-free in nfc_digital_unregister_device()

This patch replaces cancel_work_sync() with disable_work_sync() on
cmd_work and cmd_complete_work in nfc_digital_unregister_device() so
that re-arming schedule_work() calls become no-ops before the cmd_queue
is freed.

> diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
> index 7cb1e6aaae90..6def5132a4a6 100644
> --- a/net/nfc/digital_core.c
> +++ b/net/nfc/digital_core.c
> @@ -843,8 +843,8 @@ void nfc_digital_unregister_device(struct nfc_digital_dev *ddev)
>  	mutex_unlock(&ddev->poll_lock);
>  
>  	cancel_delayed_work_sync(&ddev->poll_work);
> -	cancel_work_sync(&ddev->cmd_work);
> -	cancel_work_sync(&ddev->cmd_complete_work);
> +	disable_work_sync(&ddev->cmd_work);
> +	disable_work_sync(&ddev->cmd_complete_work);

[High]
Does this fully close the use-after-free window, or only the workqueue
re-arm portion of it?

Once digital_wq_cmd() has handed a command to the driver via
ops->in_send_cmd(..., digital_send_cmd_complete, cmd), the driver
retains a raw pointer to that digital_cmd in its own async machinery
(for nfcsim this is dev->recv_work / dev->arg, for real drivers it is
URB completions, timers, etc.).

disable_work_sync() on cmd_work and cmd_complete_work waits only for
those two work items; it does not synchronize the driver's async
completion path.  When that completion later fires it calls back into
digital_send_cmd_complete():

    static void digital_send_cmd_complete(struct nfc_digital_dev *ddev,
                                          void *arg, struct sk_buff *resp)
    {
            struct digital_cmd *cmd = arg;

            cmd->resp = resp;

            schedule_work(&ddev->cmd_complete_work);
    }

The subsequent schedule_work() is correctly a no-op after
disable_work_sync(), but the cmd->resp = resp store happens first, on
a digital_cmd that the cleanup loop in nfc_digital_unregister_device()
may already have kfree()'d.

The same reproducer described in the commit message applies: in
nfcsim_device_free(), nfc_digital_unregister_device() runs before
cancel_work_sync(&dev->recv_work) and before dev->up = false, so a
pending dev->recv_work blocked in wait_event can wake up after the
queue has been freed and call dev->cb(ddev, dev->arg, skb) with
dev->arg pointing at a freed digital_cmd.

Elsewhere in this file the pattern for stopping in-flight commands
before touching the queue calls digital_abort_cmd(ddev) (see
digital_stop_poll(), digital_dep_link_down(), and
digital_deactivate_target()), which asks the driver to abort its
outstanding commands.  Would an equivalent digital_abort_cmd(ddev) in
nfc_digital_unregister_device(), before the list_for_each_entry_safe()
kfree loop, be needed here as well?

The commit message states:

    Once both works are disabled no work can run, and the cleanup
    loop frees the queue with no work able to reach a freed command.

Is that description accurate given that the driver's completion
callback reaches the digital_cmd directly through the arg pointer
rather than through cmd_work or cmd_complete_work?

This residual issue is pre-existing rather than introduced by the
patch, but it seems relevant to the completeness of the fix as
described.
