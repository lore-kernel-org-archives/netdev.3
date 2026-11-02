Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634807;
	b=cisvb12VIZtnj7ueSkAfKyR8ddipg+4+6qVlsv8ZTq0tvMl2hOHk1E7s49EcH550ohk+
	 d/70b9qiit/oSZChLmc1pI5246IfIeX7Cvmd8aLq09M3eLkBeJn69PeHwDQCqk+8kw0OV
	 ERwhkszJWIUo9PGS2AbUDLV3ZIRJvCOdZD9SyWWqbIlOvNSAa8rzdP6Cc+r3EH1g3ZrrL
	 qOBNlAJlBdY4jjGhr3kOFIeFHocOZ6GSYHFIYm9Gz3knlXIRAKZc5ks/k+XLB4+9Z091s
	 VkbNJYrAciRt9QnQZ2m4dqFVtmGFiD4fIhZJpAXNaz3W7zhAqAqqtavx7G85+rUze9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634807;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XjFbOul/AfljpdG+9e7gMBqa1iZSXAush8G4aABI3ZE=;
	b=y2S+ajTkxAymteGAf5E/SfiuBu+RN9QlCCERbDz5z08xaQ55g6I8+pUrtO7yiVrg3aQz
	 Tw2oeqxR7OfSLx/cAdZxXB+Tl3B10jCSWvnrj3Q/R726bXrKH+FPM079gV/9Q3T7qkQSh
	 iC9sWHg4Xf7lG6ByLmQGDwroUXxmbg5reDyT3a8mh04ys4XVW+LhGf4sWX0K/9p/tLX1k
	 0OaoQdFY2O8fkGhzCtlg1n4ElmvkCkxwU1qSXsX2BCOCfVrYtbWk/ba8Z6YfmTOf5DHrH
	 v2u5qcSy910OEqAGiZaVbwEl+tNPjdPPSYVXTBwIoCl1Wu6/ylflPOMdJ/tFpIem3sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrgaYHLo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83EE60AED02;
	Mon,  2 Nov 2026 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrgaYHLo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3051F01579;
	Mon,  2 Nov 2026 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793634806;
	bh=XjFbOul/AfljpdG+9e7gMBqa1iZSXAush8G4aABI3ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FrgaYHLoE0kqDMnh8dClQWdKdQKBr/kCfbbo5QLWmmLlQ3CfhXx5wA3iZKX88tetL
	 i+RoLiVZGgsnOfj8uWXJYyptOqDBFiUhOe46l0t3sFkUcDvL/d6lMlPw/dyjKkFRK6
	 keE43Nro9pLLcux7E0rJaTT8LuINmk2c5jokILcb2AahAwi12YovTgcA+gU5/BaHl7
	 pLVTqwC45905Bq6OrU2Ss87cBbi7SVof32oLIsUuWVNPuZKyrvG89VIuyJWnSo5yyU
	 vwNPVBMHNIyGtM+K8O1Rx3y3End+UfJdDgLb6XTnPK6/GvAVv2VoPAHWmb8142VIl+
	 64A0r6EhQzamQ==
Date: Mon, 2 Nov 2026 15:53:22 +0000
From: Simon Horman <horms@kernel.org>
To: Joas Antonio <joasantonio108@gmail.com>
Cc: David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Fan Wu <fanwu01@zju.edu.cn>, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfc: st21nfca: complete a pending SE APDU request
 only once
Message-ID: <20261102155322.GB865646@horms.kernel.org>
References: <179332800288.52644.8728400883396719965@gmail.com>
 <20261031182504.GW257209@horms.kernel.org>
 <CAOCBhwGBrPxLPukgH7UAoy--sOXyoWL5XsC6CmUroy0T2xujXA@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCBhwGBrPxLPukgH7UAoy--sOXyoWL5XsC6CmUroy0T2xujXA@mail.gmail.com>

On Sat, Oct 31, 2026 at 04:44:28PM -0300, Joas Antonio wrote:
> Hi Simon,
> 
> Thanks, you're right.
> 
> The two completion paths are serialised against each other:
> st21nfca_apdu_reader_event_received() does timer_delete_sync() and
> cancel_work_sync() before it looks at bwi_active, and the timer is only
> re-armed from the same HCI rx work (EVT_WTX_REQUEST). But
> st21nfca_hci_se_io() runs from the netlink path under device_lock()
> only (nfc_se_io() in net/nfc/netlink.c), which neither the rx work nor
> the timeout work takes. So:
> 
> - bwi_active, cb and cb_context are plain fields written by
>   st21nfca_hci_se_io() while the rx work or the timeout work may be
>   reading them;
> - a second SE_IO issued while one is pending overwrites cb and
>   cb_context, so a completion running at the same time can pair one
>   request's callback with the other's context, and the first context is
>   never completed. That is not new with this patch, but the bwi_active
>   check does not cover it either;
> - st21nfca_hci_se_io() sets bwi_active only after mod_timer().
> 
> For v2 I plan to add a spinlock to se_info that covers bwi_active, cb
> and cb_context: st21nfca_hci_se_io() fails with -EBUSY (freeing
> cb_context, as on the existing error path) if a request is already
> pending, otherwise records it and sets bwi_active before arming the
> timer; the timeout work and the EVT_TRANSMIT_DATA handler take the
> pending request out under the lock (test and clear bwi_active, copy cb
> and cb_context) and call the callback after dropping it, so exactly one
> of them completes it.
> 
> Does that sound reasonable? I'll rerun the emulator tests on it before
> sending.

Thanks Joas,

I am wary of scope creep. But as some locking does seem necessary
for using bwi_active to be non-racy in this patch, then yes, I agree
this is a good approach.

You may want to consider two patches in a patch-set: one to add the lock,
and another being v2 of this patch, if the changes seem to be distict even
if one is dependent on the other.

...
