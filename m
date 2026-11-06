Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997923;
	b=UZlCu4TKpKgJR42DuSvboKNJ49LF3JsfFTYBxIiWL6oitZ8PNzG46Os4vzLOcLszTrbN
	 hs7po2rkq+8/2Wcm61DPN28gyCSB9cTw8N1DgozfhVwU2DiJ8oHs6VRRptYZrSgI7KXK1
	 dX40wO51NkOFMBfRxvjNxT8VhQQVr6gsHptFveJGmCvAcPyD1kNOd/liRQ+4XHb7GiwzV
	 iKSDsWVpPQq2UFCfT+18fFN9458RSymYUOpK0Y0TBOboQtej/7AfTGnNwAl2cOw8ZlzZc
	 smSeicOK07oLjDEryZpNeW7PuM+LdwKcKuQMGC0mq96JBUvzBKHze5m6AZ4n60IxAjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997923;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yA7TVyrhvpzOOpsOEIeTMeHMpyLW3kixF8D/C0C4F3g=;
	b=QnK6rrXpSkli52lXVTWo4OyRWqAcCDfpINpiXeh/Egzt07kr3e6kGWiwuHlp6wblATl9
	 0daK6cHkSz+95tWlbY+/RPXVMHsdHWnswsnlALknra12xjDYxDCroPg1RhakFLk+FyAj5
	 NH5ou9E7va8yE9+JBMXJHAodGGLM7wV+nMXy/avTrNfhRPpN3n1XSBfsck3N9HrjRPbUp
	 9+072m3HKqlPRM9W3NTUBGS/4VoLBEMpxAalw1nqhOOvJvTuXpGfMGQqBD8ZqY4umMa3q
	 dcRHpMlilAhtN77wGnHo/5YYa1NQEb26V/msr0n1MoXlJAhi3NT5AUGLbJr1qd+8MTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzfpDkBC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B909606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzfpDkBC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BF71F0089F;
	Fri,  6 Nov 2026 20:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997923;
	bh=yA7TVyrhvpzOOpsOEIeTMeHMpyLW3kixF8D/C0C4F3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bzfpDkBCqQNC82uYCO8tAPeDNQonSlFmfX8s0k85AR+zg1ZHz0Kq5NkXHUXu5Vhlk
	 hSkOXYOgW48kZJNwnA1sYfzswAbKr6ntFYNdiLpgUVtUrQmPAQFyHjN9lMpI9VmIZE
	 gQNI//GiL/vCg3+mwzqrZ/8o9uhQCNP2f9hLHgwCjstXwi7IWWdDGc6SheCaJ1gUWv
	 /i/3VngbS0KWUzgSPQLVrCly42kPBFh5wmcumCVfNpWPhOD2Il3Rqtnlie3YPVlzg1
	 elh/KpVhS7F+57kjrSAttLjrKJZyxd9NClNkPeoyM5G/QhmhyWCSXCQ51EFSEGYeNJ
	 9n/9KSQOY/3EA==
Date: Fri, 6 Nov 2026 12:45:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rongguang Wei <clementwei90@163.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, Rongguang
 Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH net v9 0/2] tun: fix re-attaching the socket filter
Message-ID: <20261106124520.0af39146@kernel.org>
In-Reply-To: <20261030060043.94719-1-clementwei90@163.com>
References: <20261030060043.94719-1-clementwei90@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 14:00:41 +0800 Rongguang Wei wrote:
> This is v9 of the series that fixes attaching a queue to a TAP device which
> re-installs the socket filter of a persistent device.

This really needs to CC bpf@ before we apply it. Please repost.
-- 
pw-bot: cr
