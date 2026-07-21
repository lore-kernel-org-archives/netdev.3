Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE3265606
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663654; cv=none; b=t8ZRt+4QNhWulOn1qktoRmFhiQ+FzHTvDhmQ0m1IYwou0Rc3avh41ctubs0Qw2WfpYem+alZAoaAqOqHMAFjHScEGJnZxLsz8fL7IXJFf3wO8A0K4C/AzjTNRWBFy3NZJOs0PjxHXvubHxEnKC9n8PKeENM/8LZTHOV7Z+OF78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663654; c=relaxed/simple;
	bh=qwgz0f8/IU1ut/lPs3TrwB/LWjqZRO6gDHloiYWiCDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPKxoZzjZRo09T0I0hQKEfgfrNB4RXiWSLwQflTc5mZ9uKJACq93NbC87cLlxDYdIxbR3r3lMFcMg7bRHF07v2mXcp+q99KnTiqcgY8qElNZK6PGxCqdkkXLBExC5ZI/RzZSMCODIxG3mEX07ojDOb093BPu0aRDafUrrTPX4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaQgeZFZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaQgeZFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFC81F00A3A;
	Tue, 21 Jul 2026 19:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663653;
	bh=qwgz0f8/IU1ut/lPs3TrwB/LWjqZRO6gDHloiYWiCDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kaQgeZFZjoeCy4gsNI20lisFOQZeA6L0EMmOdnG4yWSFv3meLCljICgwH6Zu61xQ/
	 CR4CzbQo0IE62fUi1Ci2v0UWbnRsPNW/aJmOn82t1rebK9ypnY9zm2oJ3yTJqiqMmT
	 D6ywQlfOmcRtOfqixmDCzU3N4oWISYgNrECa1rjDAUQkIZ+R/5HcuZsRBAZVmPk8nm
	 7bjgPrk+8EoyTzAG8jVMxK9aPFA5jvth7XtkaOqV3tAZaGbB58dSaZ75bkA2Un6Zju
	 THeR70SQxM68v2XKsCl3ygMrs+arrynx9pGwlFonvF4p0gW8fGCqyZPK8Wp37PQkLa
	 N8Tt6RDSXR8Hg==
Date: Tue, 21 Jul 2026 12:54:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: <netdev@vger.kernel.org>, <brett.creeley@amd.com>,
 <eric.joyner@amd.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net] pds_core: keep the health thread stopped during
 reset
Message-ID: <20260721125412.7390651e@kernel.org>
In-Reply-To: <20260721162141.162153-1-nikhil.rao@amd.com>
References: <20260721162141.162153-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 16:21:41 +0000 Nikhil P. Rao wrote:
> Commit d9407ff11809 ("pds_core: Prevent health thread from running
> during reset/remove") stops the health thread with cancel_work_sync()
> before a reset, but a devcmd timeout during pdsc_fw_down() re-queues
> health_work, so pdsc_health_thread() runs again mid-reset and double
> allocates the core DMA queues via pdsc_fw_up().

Would using disable_work instead of cancel_work fix this without
the extra state? The patch reads a bit racy, IIUC the cancel work
can't be trusted, which in turn puts in question calling it in the
first place.
