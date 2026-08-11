Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12B33986F
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470182; cv=none; b=Jh0SA5yiP9Mn3SryHoBaANpkEvLNtApLpG52Yhp97FOmiqbYGMiMFJqIZo8cOx5VvRTJuXQjCO2DuzH/5Sj92qeYz0+KIsxgEuLEdwFAqzIw6ko/FgugNvDNsuctetndxpj5aG6DNWM3m+iqh7SLoyIJf8WWyq/6KiUoHD4qpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470182; c=relaxed/simple;
	bh=283HILvenhu4v+/Wkl0ydByCky3g4RF+qe5C5Y0HMtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLBjdEEgRDYhd7IMMQmMnB4IydqAIsQw1MsfnDjjfliXsBPO0/So3FvyE60iurdrpYLIdbtlajlBfpxjwUR4qvFxhf/wwPgGrMdTh51m2GTdgOP5V+oehvYl3T7a6/hJPGkOFjxhdxPlA7N2j4r8hIgz7NaxUtda3X9PSdpJD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj+9OSMz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj+9OSMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0841F000E9;
	Tue, 11 Aug 2026 17:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786470181;
	bh=6j00k3p9whXB3IO1NbSsdiHwDRsdkI7xxeSHo7MnEEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tj+9OSMz1pA5sbUabAl3cP0yhcP3tzfpueakD/6W8BYzMLbSqBEiox9/mg2IKsiJm
	 tmwf7ehj2nj/P71cFKyQExmjgmBL5ZmQr9zdigMHrWLzkXfEjHvoZUPsqyf7WzDx5S
	 LbcSciTb2OHSi+Ydh5Gt8bHkvlPc6L3SJ9oIix9Agj2rGcoZu+uXr8nwy5i4edbOa4
	 YIz2C0q2J7FmJJOw5gf3+TbGnawFJ1U7Q48mw2CZ8yUSoRzh9XXJbZpHFyM2vUcfCN
	 2g26KCNuoTQWxCTfB0cZ8Ey/XpiMTfA0tBT/CXGZgYxhLSS4p6K8n0tLkA20MQGSh0
	 iVU/NIoy0tMgg==
Date: Tue, 11 Aug 2026 10:43:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver
 Updates 2026-08-05 (ice, i40e, igc, e1000e)
Message-ID: <20260811104300.7a0ee9e5@kernel.org>
In-Reply-To: <1df906d3-7cd5-41b7-b23f-6601451ba5aa@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
	<20260810173508.4bec8799@kernel.org>
	<1df906d3-7cd5-41b7-b23f-6601451ba5aa@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 09:19:10 -0700 Tony Nguyen wrote:
> On 8/10/2026 5:35 PM, Jakub Kicinski wrote:
> > On Wed,  5 Aug 2026 14:35:25 -0700 Tony Nguyen wrote:  
> >> Subject: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates 2026-08-05 (ice, i40e, igc, e1000e)  
> > 
> > I only looked at the High severity sashiko reports, they look legit.
> > Please consider splitting your PRs by driver, the i40e patches are
> > likely okay. You can have multiple PRs pending for net-next, as long
> > as sum of all their patches isn't >15.  
> 
> Ok, I will look to break future PRs into smaller chunks as they make sense.
> 
> If I have a handful of single, different driver patches, would you 
> prefer to get them in a small bundled PR or individually?

Small bundle is better for us, but do what you have to to make
progress...
