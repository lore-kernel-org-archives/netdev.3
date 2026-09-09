Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B51E5B70;
	Wed,  9 Sep 2026 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912452; cv=none; b=mhp9WtO4D1IdGSVGQ5iNA2vAEzYpcLoepAaiCSPjBioC734qVXvuJlYE/dsRCFczOBy6qOLx7HTYGEvjMReG516TR4IgoKtSbq9ttB0TsUB2XlD0ihMUQMIFUpTE8CKAs0274yIE6UQo+1jn4Lui3Ts2xQItIdCxDphQGtDaPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912452; c=relaxed/simple;
	bh=VcpVxoKWJmJ+9LC27nRBgNa/npnA38cKa7KlI9T4Rp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBwzw6Z6x3b/zGHXLMFBtJ3w/ZS5cz4KPeRX3LgNNwjx2GqytvRf9mk4P0BfBpexDwX7v3VW700nJIH7uE1kPhZghdApXzA14m0VMtth+Ks9nX7OmLScV/phi5dbWtITIQMQQAc7JNdXYSCFz1D1AjPU3rIiuc35Md4zFgeJb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7CWTOl2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7CWTOl2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941BA1F00A3A;
	Wed,  9 Sep 2026 00:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788912449;
	bh=LNaOvELzNK3TbeKfcjOdnO4YUnvdu3dCSyVYn5j90SI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I7CWTOl2ztsTLiaBAm6pTVKDwJujJy3/uYBao6GZwPDX48U05bGrs3j2jEA6wX7XW
	 Tel55p/mO5hwq+mHJFEMpZReygckYByJvZ1RCkeRDNfd+Xd0PUmEjROzFVQpCMZVvN
	 NTw5XuB5rI/HMxPI14X8CH1DWmWreDylCMlHScUOa32yYb3dByJ6gDwAjD/XQZ49ZB
	 s9C+5XPs3lll5Q6KCDbZlfnprX98vwBocHHtK6iBktPSN8fJupdCCXGaF/Utv15owd
	 alALLkLt1EMLD/a46EvV506n+7ho+xVrZl6gCJ30edfyCzT1rd1zVXVFIyZVrd9+58
	 phkVEw9IRWvXA==
Date: Tue, 8 Sep 2026 17:07:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ajith P V <ajithpv.linux@gmail.com>
Cc: tung.quang.nguyen@est.tech, jmaloy@redhat.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] tipc: replace deprecated strcpy with
 strscpy in tipc_bearer_get_name()
Message-ID: <20260908170727.0c41017c@kernel.org>
In-Reply-To: <20260903132718.1616159-1-ajithpv.linux@gmail.com>
References: <20260903132718.1616159-1-ajithpv.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 13:27:18 +0000 Ajith P V wrote:
> From: Ajith P V <ajithpv.linux@gmail.com>

Full name needed. Such a damn waste of time, SMH
