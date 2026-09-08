Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD4446066;
	Tue,  8 Sep 2026 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901198; cv=none; b=eSzkcGRnK+AF+OvxSJeRmKleVbV+2SCO6cP8T9pw5jpjUGiC/bAGe7luQZvhlA8jzmYAQJKOl02ceFJBfy1eUgGgmziSL20zC1Y3k8Ixa4RVcffQaEwIVVVf5gpN24SDy7JiT0PA2auARAPg9We6/A1cAEsuMDFfBAYZcSaYf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901198; c=relaxed/simple;
	bh=R0OsQt1ajkSW6MIkNcmWF2QIdbD/km/yG98zNwZUSFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIDiE6qJIdKksqcR/MFGGXSPZQz8OuscJl5vbWGl0ehHbGAj1M3zQtxAsivqFqwNJVUDCKuGAyvK4Dqh4mKuSM+92LPzPI/vsCT+zhVmvtR5JhfSZKw9pcAQnpvHHB8KkP56SFLZhpriMQ5muxi7rorIF9F41Hxbs5Hc1MC59IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgAeG7cw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgAeG7cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8913B1F00A3A;
	Tue,  8 Sep 2026 20:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788901196;
	bh=mKvO/MlOzqKg36Pp0xw7ztTPKjQgRFh0aG04rGmqg+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KgAeG7cwqx93gtPOVRBL2HJsyfSMFA7PLwhvQg4RX/6e0DZx8wPBc7p+6aMZS7fxP
	 Lr8W9OInJcwl1/bSY/Nw1GA9Ce1JvJA9PIyGx2ZvXLru3/HTc0lPgiFnyFG2f/wUyS
	 zmts1lEUU0SpdY13eoxj98e7iSkRcpUoan4MwOiuJSgGPogs1ReKb7HfnOOGRD+2Pl
	 1zqCPd1G3GGJB+QKmkDB6SbSPtPBC5eP6aJiRWX0J82fUU5EF1/NOKw/FvbZurzaBY
	 hW4O1nvMI7LqOCGCwWx0QVb8Meqatq7Qpkvd2dO3k2mIApOHtL3+CaaAQ+9h5+XhBE
	 6T1fGjNLy0FIg==
Date: Tue, 8 Sep 2026 13:59:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>, Hariprasad Kelam
 <hkelam@marvell.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
Message-ID: <20260908135956.57f2783d@kernel.org>
In-Reply-To: <ap9zm3g92LgXyAcE@rkannoth-OptiPlex-7090>
References: <20260907042827.4077114-1-rkannoth@marvell.com>
	<20260907144038.0937d6ff@kernel.org>
	<ap9zm3g92LgXyAcE@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Sep 2026 08:01:55 +0530 Ratheesh Kannoth wrote:
> > I said:
> >
> >   drivers should not blindly pass values between uAPI and the FW.
> >
> > That means you have to add some explicit validation/translation
> > for each value even if they are numerically identical.  
> 
> A field_get() would be OK to satisfy this translation ?
> 
> cmd->base.port = FIELD_GET(GENMASK(7, 0), rsp->fwdata.port);

switch (fw_value) {
	case X:
	case Y:
		return fw_value;
	default:
		return -EINVAL;
}
