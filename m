Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE82E555;
	Sat, 17 Oct 2026 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198933; cv=none; b=HypA/qJTJ/H0sqjFWxrcfHmph4Fu2W493cyFakas0IZb0whccMuEN6v0Kj1kqL/mv6YFYXclKUeUH8Si9DU+Twa8STnYWfAO2Fja1AQv22Xz4/02B/X2+9BsO3u0bKv2T9jz0jjYl+UsV7FbNy/mCe/Z9Ty1Sk43LmZiKb8pXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198933; c=relaxed/simple;
	bh=nygAUiXFRfO54Lwz8S5KhwjcL9upT0WzVd/terf8KfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8w3Ix1HcgKzjtjOi2L1D3czdsPcHnu+aP7N0RY6WMadhooyWg0OEhPoqz7DsgeQYiSAMZXof+moyKF25+dLqUkCyLjsbOpwpzyFvO7RF15qHoJ8xJdnZYo4uu24Z3pzb7jjRcOPq1bKkjtwSMUAp/04YwQ+KF5ZM8N/9VYMYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzu6fV1I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzu6fV1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1B21F000C4;
	Sat, 17 Oct 2026 01:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792198932;
	bh=UhdE3mnZGKkTfSOIqxOZL2osYDiBv+IQLMIG+eoywpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fzu6fV1IGKkqaKhktxWvUGzdnJMZV/yhWxHeY+vnyDzxxpSN4xrpKnqHlblcEBEei
	 Ae8inV/q4VrdMbP1QEPeHKLTzb0PPcX4zAciHS0T6uLd0ec7fLZGzYkAuYtr/s8s01
	 WMJG1CLNd0JT7ZQ3DUP1QxmJtGHLoZkVb5JQ0Qdb7O0wQYurzs/3MCq6GhGeDK2/+a
	 bYhWdU6alP/bBnREA32WpGUgnR89p4OvtcSbaDvRm/CsD7sM8UqkB9E9mhDtKMgiVj
	 JRo5d/2ScOzJbV0bQS0Nj9OSa2fgmZV81L/BkdwUw0E6hnhsgE2jFn6naNgu5ioELE
	 BEDosaAQNlCTA==
Date: Fri, 16 Oct 2026 18:02:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, poros@redhat.com,
 min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 1/5] dpll: zl3073x: do not offer 0 Hz as a
 supported pin frequency
Message-ID: <20261016180210.6d1cf3ef@kernel.org>
In-Reply-To: <2f91b950-1daf-4e41-829c-5c0f02b19ace@redhat.com>
References: <20261011061211.448373-2-ivecera@redhat.com>
	<179178562093.434549.11224993829134202451@kernel.org>
	<2f91b950-1daf-4e41-829c-5c0f02b19ace@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 09:14:13 +0200 Ivan Vecera wrote:
> > Fixes: a99a9f0ebdaa ("dpll: zl3073x: Read DPLL types and pin properties from system firmware")  
> 
> Maybe, does it make sense to make another respin? Paulo,Jakub?

No need, Fixes tags and cc: stable gets picked up by our scripts
like review tags.
