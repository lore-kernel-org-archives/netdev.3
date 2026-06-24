Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1EF3B8130
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315297; cv=none; b=DwWskUiyqT9yKOMxmThL0Tv7plgL1GATpz0gT5FpA/AsICc0ktqw4ffF0gOEsZ+8xBvGuNaMRfJWWtUOeqdP49FHVx/IpH3jx9ki5bLRSmgdXBYNR1gGTG1AXzBMkGmJ/Y8mA/iZCoj29rK8ZoQim19jwvomj/EAmhdAv5jt8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315297; c=relaxed/simple;
	bh=FeGXhUrr7KAwWqca7WaPTlQuO3/AIw6AM+jlNzcvHIY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IM+3R8YQlMBZS1thubwtjsRdr1bv2XJSKkgDio7HRsXNu6n8ot03UWaLN2B1bfu08bBJ5zxA2mwbFCipC4+VuC3qXj0Po1qMj7MUQlqEm1vZau8TDHMeaGEUFFKXb+c6umfyp1fvxLgbnhIFRraZ7/9+FJh/gdYk1UEh+tTNf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mh0mn97N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mh0mn97N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA981F000E9;
	Wed, 24 Jun 2026 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782315292;
	bh=FeGXhUrr7KAwWqca7WaPTlQuO3/AIw6AM+jlNzcvHIY=;
	h=Date:From:To:Cc:Subject;
	b=mh0mn97N5LyuDTd+Oh8kqgDg+iqoUorVLwSd9/m6AdkfeAQqQI6aPjTw4KN3IIuKh
	 5EFHWxwPtTAvKTQWrrJydD8Gbcm1stf2DxF2YIr9XVW+kXtd32PAXPUji9tA+LLJLR
	 HUcCg/6Dh7zMuoan9VsxP6rEYiD7ixohKMLX0TvyeEBYw5roqcNYGFJaaOl5B5aFee
	 h+N+BTHdQTuZ2RgEctlLprL8nZP3eSrtBbnks8KAPR/eeUwlPh5sLa1y2UNdaDjFOH
	 cfUdLs1UdqqZRNrZUF7jpU4EO+GQKMhBpE4ZLA/YR+dUMGBUKkHNI2FJIKDBv51HRX
	 GD/juSdXZwDnw==
Date: Wed, 24 Jun 2026 08:34:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adrian Pielech <adrian.pielech@intel.com>, Przemyslaw Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [TEST] GRO on i40e looks off
Message-ID: <20260624083451.2c15b16b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Looking thru the stability reports GRO tests on i40e stand out.
It's bad across multiple test cases but IPv4 IP ID cases are
a very good example. These tests are solid across all platforms
but on i40e they fail half of the time both in Intel CI and
in netdev CI.
