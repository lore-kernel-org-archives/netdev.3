Received: from dianne.skoll.ca (dianne.skoll.ca [144.217.161.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9835B63B;
	Tue, 31 Mar 2026 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.161.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963691; cv=none; b=ZnNnY+u/yI8uw3ypnmPl+b+w+oSvUu21+JYF4oA1xLxoN2NLrdA7iXjMS/ptEkV7Y0DfwVxlgHMZo8ZBpI+1CFvAaiiOnWQ6R1ywblqAaeE2u6skIODWM+fpwBLBCYLic9j2IYX6+As1CwItbBnFmxhgPLdol/2QVPngabOMoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963691; c=relaxed/simple;
	bh=7MFxKShVTxd+lY7R+mrO+Qf6lV8BcIFtVcpjcItRLnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdBWamyBkEyoQJqaQ65s1kikS+Mqmv/1dN0EH38DRw4Mfa+JCFA2XIdFFqCkgqgp5FJo/jKej9PNhYYKVKYv4V3aFkeT7RHJwnLajXJ0gZrXv8Qs1X532xIbaLmMMtmGoCJLwwg1rSQCrZUijg4Ugve95fNkhwhPY40atgmakkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca; spf=pass smtp.mailfrom=skoll.ca; dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b=qQtF0T0u; arc=none smtp.client-ip=144.217.161.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skoll.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b="qQtF0T0u"
Received: from pi4.skoll.ca ([192.168.84.18])
	by dianne.skoll.ca (8.18.1/8.18.1/Debian-6) with ESMTPS id 62VDGwqq821975
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 09:16:59 -0400
Received: from gato.skoll.ca (gato.skoll.ca [192.168.83.21])
	by pi4.skoll.ca (Postfix) with ESMTPS id 4flTDB0jcczdZXB3;
	Tue, 31 Mar 2026 09:16:58 -0400 (EDT)
Date: Tue, 31 Mar 2026 09:16:55 -0400
From: Dianne Skoll <dianne@skoll.ca>
To: Jaco Kroon <jaco@uls.co.za>
Cc: Qingfang Deng <dqfext@gmail.com>, linux-ppp@vger.kernel.org,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Mackerras
 <paulus@ozlabs.org>,
        James Carlson <carlsonj@workingcode.com>
Subject: Re: [PATCH net-next] pppoe: update Kconfig URLs
Message-ID: <20260331091655.30212333@gato.skoll.ca>
In-Reply-To: <0aa6aa20-0e2a-48e9-8273-53b2fecd287b@uls.co.za>
References: <20260331033303.5664-1-dqfext@gmail.com>
	<0aa6aa20-0e2a-48e9-8273-53b2fecd287b@uls.co.za>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skoll.ca; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=canit2;
	 bh=N+o/fN6BS9t/TFQkepTVDOf/PV5JJHZ1MG5m3Iia2pE=; b=qQtF0T0uQ3rv
	K2GevO5H8WxzEB+0OqJJoAo9Bi7oO35liWdNLePTxjYCmxd/bsGQxt9F9tna2HCF
	qBsklxR/zMtyRp9FyOCi6zGZUMwvUD8aHYI6wmdNgKB8rvoiVEPJgZuecttWjoPG
	GDm8fbER9GSioRfvb2szvQJtIasTdpfOGWHy4WApEAfMZ84m8Y64hExT9K03f6aO
	Q58JjmLCHPx3UCW2B7bDfREetn4V8fkmM2TX8qi0RlTju9yJWS9W2QZffos8ShAu
	HDkQx24YdeuGXk2IF7hFKTkV3YPwlVHfy5pxCmBPOLP1VSBs5uUFOTnPJqoDSXuq
	S4dnXiyXQA==
X-Scanned-By: CanIt (www . roaringpenguin . com)
X-Scanned-By: mailmunge 3.20 on 192.168.83.18
X-Spam-Score: undef - relay 192.168.84.18 marked with skip_spam_scan
X-CanIt-Geo: No geolocation information available for 192.168.84.18
X-CanItPRO-Stream: outbound (inherits from default)
X-Canit-Stats-ID: Bayes signature not available
X-CanIt-Archive-Cluster: tWKWaF/NcZkqjWIj0BEJTBHJhwY
X-CanIt-Archived-As: base/20260331 / 01gVpgW3L

On Tue, 31 Mar 2026 08:21:40 +0200
Jaco Kroon <jaco@uls.co.za> wrote:

> That same code has recently been dropped from rp-pppoe,

That is not the case.  I still ship all of the plugin code with rp-pppoe.

> Most people will never need rp-pppoe.

This is correct because the ppp project *also* ships the plugin code.

Regards,

Dianne.
