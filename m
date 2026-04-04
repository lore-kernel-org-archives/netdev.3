Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308A1531E8;
	Sat,  4 Apr 2026 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775289255; cv=none; b=rT6MsUg0lmSVVzK4GTdbnyuFlfQPefBPQ52w35x/+R/BMGLvXysZbCVD5ai/NDDjEm/FSxIWjtXxyglba9sHpMhEjZOHhzIVIWXrOrxqQ7nOsbwaZuh7HKGwB//SDogVM0E6U6vOWtf6nMAmzsHptTbcXq94ohQm/h3GfOX2h4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775289255; c=relaxed/simple;
	bh=YMXx3Itf1JhFfIb+aobrBUQ59FAYay00gTLdS3m6lG8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9eggh7CiIa52YGBzbaJMn7k1aw8u6pZhBZ4qr0ljGhEQXZgFDd4rOrpvmtM9VxHVgRwXZiRGHIPt3wVBGFfPJOGwv4aCGj2cNe1tgIVmRIn5o+6SJvXJDZQCtfduU4nyaQz23dxF5yCnCRgQiW5pFLLP6msncXX/0mK2udx+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B40FC19423;
	Sat,  4 Apr 2026 07:54:10 +0000 (UTC)
Date: Sat, 4 Apr 2026 13:24:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Yiming Qian <yimingqian591@gmail.com>
Subject: Re: [PATCH v2 0/5] net: qrtr: ns: A bunch of fixs
Message-ID: <kgoysvkrt2m4ap65p3iylgurlf7r6gdo4hczxly4letowjlic6@pf66tyhaqnil>
References: <20260403-qrtr-fix-v2-0-f88a14859c63@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260403-qrtr-fix-v2-0-f88a14859c63@oss.qualcomm.com>

On Fri, Apr 03, 2026 at 09:36:03PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series fixes a bunch of possible memory exhaustion issues in the QRTR
> nameserver.
> 

Gosh. I messed up the cover letter. Please ignore the below: 

> Manivannan Sadhasivam (2):
>   net: qrtr: ns: Limit the maximum server registration per node
>   net: qrtr: ns: Limit the maximum lookups per socket
> 
>  net/qrtr/ns.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
> 
> --
> 2.51.0
> 

Until here...

- Mani

> ---
> Manivannan Sadhasivam (5):
>       net: qrtr: ns: Limit the maximum server registration per node
>       net: qrtr: ns: Limit the maximum number of lookups
>       net: qrtr: ns: Free the node during ctrl_cmd_bye()
>       net: qrtr: ns: Limit the total number of nodes
>       net: qrtr: ns: Fix use-after-free in driver remove()
> 
>  net/qrtr/ns.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 61 insertions(+), 10 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260331-qrtr-fix-b502c26e5f46
> 
> Best regards,
> --  
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
