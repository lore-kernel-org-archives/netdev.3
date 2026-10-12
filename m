Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9F47012D;
	Mon, 12 Oct 2026 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795969; cv=none; b=Jxi6sG4nluiyyWliASx0ztXxPQRbZ+PiVI99xGr/6/GYH2gyHxM1HFFQjnz207FYzx7cxO+vBvxwyY+kRTlsbf0hWFPu7QPBOY5DFn4+iDNwV+sy+whAdlJsLEHnniTkZ0bL9YAeguQtdw1p22fIdVZ3x5ehT6B2/Dtzy5Phmw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795969; c=relaxed/simple;
	bh=3RTmTHttyu337r6q2363XzLyTy9y6YE5j8Ckgq9stAA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iabX3apELG4plXeQ1nkJ5gQ4THjQv4eCnKhvYNU6k2j0cYdV8KqFoFSFB59b4+qKdVxx3ooZgCp/bCmyd9gdjp+t9JsmMWRLd7M9q7mMTCI4YhN+6+dhijAL8tzn0NhiTAsSCazSUWvfI56DiG8oQnKo6ONTVnIrpZiAvk+3DWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3+aFWbW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3+aFWbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6A01F0089C;
	Mon, 12 Oct 2026 09:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795968;
	bh=3ikX/qWgpALoOsA6FUZGIQdtLRadC2EsIistCwELo+8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b3+aFWbWi3aJpmx4axm+Jg2Cdv92/IU2DzF20wX1HqlWJ8Gi9DXIxXGDmRc8DaQ2+
	 9qHX8GMtekbJdhaNqQgf1mRD+VzGwwFKqZrUuU3nCqyh6VphsWsF/JIQ8BgKa17LiV
	 /Kev1c/OUCuB1zw+Dw1ykpWgTcoK0ObQ+ZR6qeYSn006HKHYVPjje/YXwKolIsdSdO
	 R6q+elq+ZzXDFMBR/dJo/jIbPVgiGz2Jda2Fc26ziavwfiAa9KMTjSFegBG01YfliR
	 380/RzO4x8xA33xp5rcs82SweLlj2KBNmjnN4pQ37pkFJgdiwjlgvhiMRMgMus9v3F
	 qy3L/mOsxTDeQ==
Subject: Re: [PATCH net-next v6 01/10] r8152: split r8156_init per chip and
 factor out wait_autoload_done
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch,
 mail@birger-koblitz.de
Date: Mon, 12 Oct 2026 09:06:07 +0000
Message-ID: <179179596716.434549.7821024707462218162@kernel.org>
In-Reply-To: <20261008081556.47901-2-nic_swsd@realtek.com>
References: <20261008081556.47901-2-nic_swsd@realtek.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says r8152b_init() was converted to
  wait_autoload_done(), along with r8153_init(), r8153b_init(),…

--

r8152: split r8156_init per chip and factor out wait_autoload_done

This splits the shared r8156_init() into r8156_init(), r8156b_init(),
r8157_init() and r8159_init(), one per chip family. It also adds a
wait_autoload_done() helper built on read_poll_timeout(). The helper
replaces the open-coded PLA_BOOT_CTRL/AUTOLOAD_DONE polling loops in
several init and UPS functions.

> r8152: split r8156_init per chip and factor out wait_autoload_done

[ ... ]

> Also factor the repeated "poll PLA_BOOT_CTRL for AUTOLOAD_DONE" loop
> into wait_autoload_done(), reusing read_poll_timeout() instead of the
> 500 * msleep(20) busy loops. r8152b_init(), r8153_init(),
> r8153b_init(), r8153c_init(), r8153b_ups_en() and r8153c_ups_en() are
> converted to use it too.

[Severity: Low]
Should r8152b_init() be in this list?

r8152b_init() in drivers/net/usb/r8152.c has no PLA_BOOT_CTRL/AUTOLOAD_DONE
polling loop, either before or after this patch, and the patch does not
change it. Its name only shows up in the diff as the hunk header for the
r8153_init() change:

  @@ -7225,22 +7226,14 @@ static void r8152b_init(struct r8152 *tp)
   static void r8153_init(struct r8152 *tp)

After this patch, wait_autoload_done() is called from r8153b_ups_en(),
r8153c_ups_en(), r8153_init(), r8153b_init(), r8153c_init(), r8156_init(),
r8156b_init(), r8157_init() and r8159_init().

Could r8152b_init() be removed from the list of converted functions in the
commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008081556.47901-1-nic_swsd%40realtek.com
