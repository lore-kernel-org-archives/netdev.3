Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A519A288;
	Sat, 31 Jan 2026 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769819907; cv=none; b=Fajw2WdPJsywEDFrC9rzpRAiRqkOVLA9borf1F49saAzT+aJ6JumOaT6mgc0Dfgqt/Rac5yQhyYBF4zdR1d25UbNY02FbVQApN8HnjyjL8qzR7fJRb0CrHbWfuBxqpjyI+aa1xs8ouLP90I1poYRR27fgnr9bMPa2AzFyI0HISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769819907; c=relaxed/simple;
	bh=Jdd3buLMaqZBkACwxbSaZ9XyMhBAqA5jAjxcO9QTh9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+ALXqIiwOIVfSJUqiWPTxf6oQQPe9GO1o8sFxPw4ajfkF36wzypX+d1VtGNuBMBg7AdNz6Ru39tYa5ncx+aeD5CSO9U8SJm4U2Z8WB7Pt+ee2T7Wc4MFrg6J7dymHRYfdgKF5tN60aeS8cGfnHEQOAC5UqzBBNBE40KHBxizpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYnxHnU/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYnxHnU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F75C4CEF7;
	Sat, 31 Jan 2026 00:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769819907;
	bh=Jdd3buLMaqZBkACwxbSaZ9XyMhBAqA5jAjxcO9QTh9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bYnxHnU/XJ9Lk3D3akKRWErAxebiOZiN+kzUeQWoviWRVSAWgyfw3bHNYtPh1qdXA
	 hGEpFGoyweQuOeWSBNm7f2vRN6k3b2i3q0kheVi6pnSmB3WWevIouZYMhOx1krHN1N
	 yAjWxNv05ePs/d12c96gt4DeQboX9AN6QyO/9cqNUP9AyPSP8pHlN5ubIaly2KxW/P
	 qiNQyFR64beaeD+/ja7YCcglAU63W+qnscbckUh9A0+TeYf2ZL/g5Zzwvmymk8dG7q
	 OVeRmngY8jPaXfQ1cj5PQLWceUHwSE+Kay6q3yCiuCGm05ceeVDSvJrDMSsCj34STd
	 w+yl4p/EOAeyg==
Date: Fri, 30 Jan 2026 16:38:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>, Ankit Garg <nktgrg@google.com>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org,
 Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Catherine Sullivan
 <csully@google.com>, Luigi Rizzo <lrizzo@google.com>, Jon Olson
 <jonolson@google.com>, Sagi Shahar <sagis@google.com>, Bailey Forrest
 <bcf@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] gve: fix crashes on invalid TX queue indices
Message-ID: <20260130163825.3b63222a@kernel.org>
In-Reply-To: <CANn89iJ=Gfjves4qN6hu_VRPSedVRosJsvEQC_irFnEJU_eMLg@mail.gmail.com>
References: <20260105232504.3791806-1-joshwash@google.com>
	<20260106182244.7188a8f6@kernel.org>
	<CAJcM6BGWGLrS=7b5Hq6RVZTD9ZHn7HyFssU6FDW4=-U8HD0+bw@mail.gmail.com>
	<CANn89iK_=W8JT6WGb17ARnqqSgKkt5=GUaTMB6CbPfYuPNS7vA@mail.gmail.com>
	<CAJcM6BH11e4Cs3=7B3Uu-JxPeq4BAnQ3VDLfCAN_JcfnPLtOaw@mail.gmail.com>
	<CANn89iJ=Gfjves4qN6hu_VRPSedVRosJsvEQC_irFnEJU_eMLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 21:56:07 +0100 Eric Dumazet wrote:
> Jakub, the issue is that before 4.20, calling synchronize_rcu()
> instead of synchronize_rcu_bh()
> was probably a bug. I suspect we had more issues like that.
> 
>  __dev_queue_xmit takes a rcu_read_lock_bh(), while the code (that you
> added in 2018 [1])
> to update the queue netif_set_real_num_tx_queues does synchronize_net()
> (aka synchronize_rcu()) and in earlier times, it would mean that this
> would maybe return too soon (say on preemptible kernels)
> 
> [...]
> 
> So perhaps a fix for pre 4.20 kernel would be: (I kept the
> synchronize_net() to be really cautious and because I really do not
> want to test)

Sounds entirely plausible, FWIW. Ankit, this would mean that you have
to convince RHEL / Rocky to take Eric's patch. Oldest kernel we can
patch upstream is 5.10, AFAIK.
