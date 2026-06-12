Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF59262A6
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781307295; cv=none; b=FsJXTqw20cuPvIE55rXyLQ72XZYDUE0D3K4LCp/3VeWep3J1j17kPqspJDr8VPhGKaAq+Rb33j2V49zSJ0UMe01oYBb3VSt69CqjJXa8htKLLQbcptdFQ9zPNu5ntibpu7VZzzxToR798eQ11uNABVRidRD9YWZpMNVcGAkQI/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781307295; c=relaxed/simple;
	bh=lT6kT342ohhm53XEx3YEsmCHr8IOTytEXglIvzgw62g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZjiD4xIerqTxMaTCnXlbdUyhypUflarRa26n5t/+N5VdZd0IT3oBzHajvc1GPJj33dIoA8pLPorISrEGUajoAVAcddhRnSSrv7tHOHHFdpIDXblNzMc+6NsZGfdb/IemKD79VtWQw3ruqNFQ71uWwuvLWPA9sjdauc8Q7vD0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c92EFRws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c92EFRws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224B91F000E9;
	Fri, 12 Jun 2026 23:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781307294;
	bh=lT6kT342ohhm53XEx3YEsmCHr8IOTytEXglIvzgw62g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c92EFRws0jfd6Lq03kDkK0VI1EKWkY03TrVbRWZ6yFoz2skx47ZjiiJ/w31KHi+OE
	 jGGPcYp0L9YtFLmRzHo1/Z1EaEis6JtI39tm6jSe8DnNna3XTchmI8lRbTtqs/ksh+
	 RDEqL4lQKXo4KTymYNBmMAO8QXAdeiN1mnsWgJUxHMyYWBx8DXB9w3KeddlQpWnX05
	 NPlbjHiTUsuJBhPJM1VNGUoAcn9BcN7oyIQnzAPKNGN5d6P18bKc80uCj0fwGL9pi+
	 sR3Vl8Hy7l22/i/yV4d5g3DdJ7VajPxKjc1JMJB4Gc6L/gTOxJICLn9QjfV0nKCZKN
	 UxtX1AiJ3acww==
Date: Fri, 12 Jun 2026 16:34:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 3chas3@gmail.com, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, tr0jan@lzu.edu.cn, zzhan461@ucr.edu
Subject: Re: [PATCH net 1/1] atm: svc: fix listen state corruption in
 svc_listen
Message-ID: <20260612163453.3d526c28@kernel.org>
In-Reply-To: <4af79c95e316b9a65a4c6302fc912a5944198b6b.1781031726.git.zzhan461@ucr.edu>
References: <cover.1781031726.git.zzhan461@ucr.edu>
	<4af79c95e316b9a65a4c6302fc912a5944198b6b.1781031726.git.zzhan461@ucr.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 01:33:27 +0800 Ren Wei wrote:
> --- a/net/atm/svc.c
> +++ b/net/atm/svc.c

I'm going to send a series to remove svc.c shortly.
Could y'all please steer more towards code that has been used in this
decade?
