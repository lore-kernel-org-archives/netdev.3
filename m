Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759F3369999
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641111; cv=none; b=SoqWx+S4GZPBY4WUFjG7+l9yaQUCSiEGLjtyNVxUu8GE3ZxQ8UqmMrrQcorHubs6+UAwvUTDEyQYrP/my7/jtV+t4hRVVAYda4WsNWHz3TdzJn/+lT7x3YIZlVDUQc7hBMGrrzMq1nsPvzg2hh4T/KLBl/4YCJyyECafRYL9kW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641111; c=relaxed/simple;
	bh=BtdnwITbgag9RG1Ywem2LcmLEI1WvRhFchAkoELaDcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uoqq8VFrtJSosKXPXgsQu2UUx4GqXqDQb8E4JqHQD3KgA1Jo9JswtYhbCWDOicmlJ1PH5Q+eVFjVJv0P3t8C2oQGShO+pg6MqZ5su4okHbJVUnNMWs66voL+5niWjIQrq4PsKzy0B1g5rhLBKa/ywAIw8EUw6/LrPJufKokqeqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoD66VFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoD66VFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C751F00A3E;
	Tue, 21 Jul 2026 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641110;
	bh=3QGqALS7OQg0zs78rCPEBVMr3YWMM2jfGKC+HX/Ca4w=;
	h=Date:From:To:Cc:Subject;
	b=KoD66VFGB2Q33vJc5aUCdp0QDJRIYB0yGnFAp9ua++RWZD1BT+iNadLs80mbSO8ex
	 s4tvtqO+pQj2z2g7p/ZWCeKuh8L8kOfr95iaQl0qAA8qvxnvLFYW0TBKdtyiBFVbtg
	 4RbKAOPXzt516J1DFyOlmzqBE405YsCevhd1VnBGSIk5/49qxnsJn329Jr4AR9Hwoe
	 41k1foeNKEumTGxMhC2QV2yLIIHYbOZ4EQdWArCUdgLvMUapTCZZBsPPLbhC+J8Aa6
	 VXnUXbteEwb9/ZtomxWSAb1PZjExK3q3DUeSioq+A0PlykhqugMbHe9eou9xVC3tql
	 887cTQakOQA4A==
Date: Tue, 21 Jul 2026 06:38:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sheena Mohan <sheenamo@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: [TEST] google runner needs nested cases
Message-ID: <20260721063829.7d9e6c7f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Another ask, please parse the TAP output of the tests and provide 
a nested array of results per-subcase, see:

https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system/#results

right now you only seem to report top level pass/fail but most tests
have at least one sub-case the driver doesn't support.
