Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1CB16132A;
	Wed, 10 Jun 2026 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056757; cv=none; b=kfIS3ifhww86Pb6WbKZtY+TevgDs/vwi4iP78qbQsgVMUQ7t7vH9aQmB3YmJs9jlMd8GTEkq8zk9YaQLRMA//JO+d/XP1vd4vKfxhI/r2lIklWEJ00t94Eyjvhg2IbJGgGdq8r/8o7KuwASHh2s5Q8HKe+8pOmtuoz+/IqsSeqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056757; c=relaxed/simple;
	bh=21kY2+Fqg0W8A8HmNPWueFtJrpgvxP5JBgkaXuBI+Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8BJ6dXBlzkh2BCGmgKkgBgKO807xmWbsr4CviaAtQDtNnEAfSy2v/jP1OHJO9R0sIAg3hhbkolAxcPB31VxlatAgMA9iCjShxEwwstgbeube2cMnFYQ5BW3I6r2ij4logHj4uFxa4TXTXcm1MNZIAnaypIqXR4vrSV4qNoS+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+o+2oX3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+o+2oX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00CA1F00893;
	Wed, 10 Jun 2026 01:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056756;
	bh=LMo1YyeYGJbjVv1s9cUp1DtWyjbOOHVtkp74mFCuma8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f+o+2oX3F6xjQkWgOdSyDCvfM62GSugEJzF8gOnm6aJ2VwDMeijjoaAOiTqG4juxo
	 mzR3Cq75lQ5W6N2aXbk2ZQySp31dVk6/Y1uGywl6elSWasftdhogSHOfX3INHqSbH8
	 Zd7dEu2y55bOzO6k9JeLLm94Aj8WKBPjKUasGgdkFvloaBy4QMBluKIB4h2NOVCDlM
	 RU36YAEKBv5e22iFW6a+o0JBojQ1yobEzW1WacARf+AqWrtl4XwcYRQcUcrLSEVY51
	 bufT0ZwISiLju7NiCawZH0TfrE6n4xl/FV/rGBXqbrZ1cKuMW8Q2iiMb+YJ1wWP44N
	 eh8gPYgF8PKSA==
Date: Tue, 9 Jun 2026 18:59:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: sja1105: Add rev-rmii support sja1110 devices
Message-ID: <20260609185915.7aa34d8e@kernel.org>
In-Reply-To: <20260608141654.2003932-1-martijn.de.gouw@prodrive-technologies.com>
References: <20260608141654.2003932-1-martijn.de.gouw@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 16:16:51 +0200 Martijn de Gouw wrote:
> When a rmii port is used in phy-mode (rev-rmii), the ref_clk is an input on
> the rx clk pin. Configure both the rx and tx clock source to use the
> rx_clk as external clock source input.

drivers/net/dsa/sja1105/sja1105_clocking.c:969:5: warning: no previous prototype for function 'sja1110_clocking_setup_port' [-Wmissing-prototypes]
  969 | int sja1110_clocking_setup_port(struct sja1105_private *priv, int port)
      |     ^
drivers/net/dsa/sja1105/sja1105_clocking.c:969:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
  969 | int sja1110_clocking_setup_port(struct sja1105_private *priv, int port)
      | ^
      | static 
-- 
pw-bot: cr
