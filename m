Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9662BF00A;
	Wed, 11 Feb 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818800; cv=none; b=VRdlRfGoZ/WCqh1a05Ebk8EE5WDaMSMiXjPAFGnBdn1N2NYyriuQoWLBDjbppgmYjp3cFzbNFPCfZ5qSoo2LqJzxa4cfGajNJxD6aHfAIzqafQwryGnm21GVFRVJTGHmry/uuzd0AixtBqf89YwLcsLcYn746h0wf4QFribQJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818800; c=relaxed/simple;
	bh=+ZY2hC9Nf4WFIOZX5tMFvL7e5tJDu/RsbdiAfCOMESQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6N3ZiXVWMFnxuU7ng2uI6C0KA3qaDMhnUMwioVg4NKbtqxeLx6ivhs5uoFVTrhzRQ9u98BbTQ9mEY5o8+5P7y8KOxLl9cw/jqNt9Up0fh+46r1gVVSXE18NrGvByrM3BxQZyJyraomGCJZWJWn7stYfRutyoST4fD29T9x8IFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbgvUFcp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbgvUFcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04725C4CEF7;
	Wed, 11 Feb 2026 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770818799;
	bh=+ZY2hC9Nf4WFIOZX5tMFvL7e5tJDu/RsbdiAfCOMESQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbgvUFcp+H17pUDZuFBX5Q9ou0GxXC00cqAeGp7NGc2fDFt0ZSgFYTcTvWuNlds1r
	 2oQeHA4bYR9CViMyl4ehjrkm8fjPdffIDpJ/gDPPhzlaQqOOnzOz7Z7j2OjEmcNo+L
	 U2dseUlIS2O+W/Wd/y3Xfr5TqN7YnDMM/uRmAM90UzK9BQz5TXY0mhwoiWGwT6B11s
	 IEjl2SHUX4KFMDKK4+zYQxdfrE/JzNmdfuR3WSbJhf18J7IeEqux/kAaLJcJzLy0YY
	 jxuf+rlthPm4qiS7ZQg5Vi4QWzWxakrCavKYFOOnYJKXp6lv2w8Q6Ze94zA+hueRPc
	 FdQLCAiGBJ1YA==
Date: Wed, 11 Feb 2026 08:06:35 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn.andersson@oss.qualcomm.com, chris.lew@oss.qualcomm.com, 
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH] net: qrtr: Expand control port access to root
Message-ID: <3bd7zvejjl6slge277gv2pfktqc45rcgu6fpmmd7zm2lpnq26d@avrdwhy5zpmz>
References: <20260205-qrtr-control-port-access-permission-v1-1-e900039e92d5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-qrtr-control-port-access-permission-v1-1-e900039e92d5@oss.qualcomm.com>

On Thu, Feb 05, 2026 at 01:51:31PM +0530, Vishnu Santhosh wrote:
> When qrtr is loaded as module, qrtr-ns runs from SELinux kmod_t
> domain.

It wasn't clear to me that "qrtr-ns" refers to the net/qrtr/ns.c, not
the deprecated "qrtr-ns" utility, until I spoke with Chris last night.

Perhaps it's just me, but I would appreciate if this was made a bit
clearer. Writing "QRTR NS" instead of "qrtr-ns" would have been
sufficient.

Regards,
Bjorn

> On targets using upstream SELinux policies, this domain
> does not receive CAP_NET_ADMIN, which prevents it from binding
> control port even though qrtr-ns is a trusted system component.
> 
> Granting kmod_t the CAP_NET_ADMIN capability in policy is possible,
> but not desirable, as kmod_t is not expected to perform networking
> operations and widening its capability set is discouraged.
> 
> To address this in a contained way within qrtr, extend the control
> port permission check to allow binding when either:
> 
>   - the process has CAP_NET_ADMIN, or
>   - the process belongs to GLOBAL_ROOT_GID (root-equivalent tasks)
> 
> This permits qrtr-ns to successfully bind its control port in
> kmod_t restricted environments without broadening SELinux capability
> assignments.
> 
> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> ---
>  net/qrtr/af_qrtr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index dab839f61ee93b876021d904ae6b8dca8ed43745..b0e252c16f156c05973988fbdf317a149ad9840d 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c
> @@ -8,6 +8,7 @@
>  #include <linux/qrtr.h>
>  #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
>  #include <linux/spinlock.h>
> +#include <linux/uidgid.h>
>  #include <linux/wait.h>
>  
>  #include <net/sock.h>
> @@ -738,7 +739,8 @@ static int qrtr_port_assign(struct qrtr_sock *ipc, int *port)
>  	if (!*port) {
>  		rc = xa_alloc(&qrtr_ports, port, ipc, QRTR_EPH_PORT_RANGE,
>  				GFP_KERNEL);
> -	} else if (*port < QRTR_MIN_EPH_SOCKET && !capable(CAP_NET_ADMIN)) {
> +	} else if (*port < QRTR_MIN_EPH_SOCKET && !(capable(CAP_NET_ADMIN) ||
> +						   in_egroup_p(GLOBAL_ROOT_GID))) {
>  		rc = -EACCES;
>  	} else if (*port == QRTR_PORT_CTRL) {
>  		rc = xa_insert(&qrtr_ports, 0, ipc, GFP_KERNEL);
> 
> ---
> base-commit: f14faaf3a1fb3b9e4cf2e56269711fb85fba9458
> change-id: 20260205-qrtr-control-port-access-permission-bfea19994a58
> 
> Best regards,
> -- 
> Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> 
