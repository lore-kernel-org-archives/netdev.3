Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA05E2D0C64
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408510; cv=none; b=WcpOfRP7+fhPBsZCJa5NK1v3VMUQhOu57h5N0LUlkmvKLfPY9k1IoFKy8OcZejl2qkRLod4WjRRgZxxIC/lC5zVAhSH1K8BoaqoNUTa0wUSxJ9z/ydWou+8wy+mfLBZezxvE85xmNWS/BOXv3jLS67U1gdFvLoKwTCQ5nNrzG/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408510; c=relaxed/simple;
	bh=ZDZfHQr70nN2jCvZ/WWWxYohJj6wqGTqrH27hjFpFDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h90Gw+W+hTGQ7zhAwzxfdgJyK85VPqiOoNiqT6eGDh4iWRcHPZP66AnQHg1SThNu8jYgRwB7R/h/wEuDNnVD2lCpKfjkL6+n+/P7vOzcHgl96C9QjLAcl2EwikG5yEdSfXhCf57SGKenMfCCXiGWifJa11nNDMHno81MNY9jgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbgjsiMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbgjsiMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A481F000E9;
	Tue, 11 Aug 2026 00:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786408509;
	bh=qX+Z3J+a9EMRoUqDArlSMfMBOKh39R8ZSIKLpQJ8lDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jbgjsiMOi5pOidgwy+Z6771wvNiHF6R97tlkpw6U9Tqo/RInXyWK6i1hh6NkDCrpv
	 YrI7/mFv5ccib+hIYH9JrW0GnVOtxbJyH60LURLC7Ebcg2V8D3roFrJjuRjC9waglF
	 O+7bNYu2UltiD4WFRUpXfy47bFWjoc0V2AsMFVj0LuZjZbJuJgUdVUPyYLFt8OIXkY
	 Llp4sS++XEjaZqMHqpRcx1tKInkJQJJPBPQcDEoev9LGYzuXN6sAOYLLNdunFxLoDV
	 jqgTHDYJNTiDktKelGMTInr2b9btXDDuFFVKgG/KBx0CDFYIHBD+i7uAM8a4SfAWOM
	 wRhuQUmd4EUsQ==
Date: Mon, 10 Aug 2026 17:35:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver
 Updates 2026-08-05 (ice, i40e, igc, e1000e)
Message-ID: <20260810173508.4bec8799@kernel.org>
In-Reply-To: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 14:35:25 -0700 Tony Nguyen wrote:
> Subject: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates 2026-08-05 (ice, i40e, igc, e1000e)

I only looked at the High severity sashiko reports, they look legit.
Please consider splitting your PRs by driver, the i40e patches are
likely okay. You can have multiple PRs pending for net-next, as long 
as sum of all their patches isn't >15.
